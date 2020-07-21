/**
 *
 * Copyright (c) 2014, the Railo Company Ltd. All rights reserved.
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either 
 * version 2.1 of the License, or (at your option) any later version.
 * 
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 * 
 * You should have received a copy of the GNU Lesser General Public 
 * License along with this library.  If not, see <http://www.gnu.org/licenses/>.
 * 
 **/
package lucee.commons.io.res.type.s3;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.LinkedHashSet;
import java.util.Set;

import lucee.commons.io.StreamWithSize;
import lucee.commons.io.res.Resource;
import lucee.commons.io.res.ResourceProvider;
import lucee.commons.io.res.util.ResourceSupport;
import lucee.commons.io.res.util.ResourceUtil;
import lucee.loader.util.Util;
import lucee.runtime.exp.PageRuntimeException;
import lucee.runtime.op.Caster;
import lucee.runtime.type.Array;
import lucee.runtime.type.util.ListUtil;
import org.apache.commons.lang.NotImplementedException;

public final class S3Resource extends ResourceSupport {

	private static final long serialVersionUID = 2265457088552587701L;
	
	private static final S3Info UNDEFINED=new Dummy("undefined",0,0,false,false,false);
	private static final S3Info LOCKED = new Dummy("locked",0,0,true,false,false);
	private static final S3Info UNDEFINED_WITH_CHILDREN = new Dummy("undefined with children 1",0,0,true,false,true);
	private static final S3Info UNDEFINED_WITH_CHILDREN2 = new Dummy("undefined with children 2",0,0,true,false,true);


	private final S3ResourceProvider provider;
	private final String bucketName;
	private String objectName;
	private final S3SDK s3;
	long infoLastAccess=0;
	private int storage=S3.STORAGE_UNKNOWN;

	private final boolean newPattern;

	private S3Resource(S3SDK s3, int storage, S3ResourceProvider provider, String buckedName,String objectName, boolean newPattern) {
		this.s3=s3;
		this.provider=provider;
		this.bucketName=buckedName;
		this.objectName=objectName;
		this.storage=storage;
		this.newPattern=newPattern;
	}

	S3Resource(S3SDK s3, int storage, S3ResourceProvider provider, String path, boolean newPattern) {
		this.s3=s3;
		this.provider=provider;
		this.newPattern=newPattern;
		
		if("/".equals(path) || Util.isEmpty(path,true)) {
			this.bucketName=null;
			this.objectName="";
		} else {
			path=ResourceUtil.translatePath(path, true, false);
			String[] arr = toStringArray( ListUtil.listToArrayRemoveEmpty(path,"/"));
			bucketName=arr[0];
			for(int i=1;i<arr.length;i++) {
				if(Util.isEmpty(objectName)) {
					objectName=arr[i];
				} else {
					objectName+="/"+arr[i];
				}
			}
			if(objectName==null) {
				objectName="";
			}
		}
		this.storage=storage;
	}

	public  static String[] toStringArray(Array array) {
        String[] arr=new String[array.size()];
        for(int i=0;i<arr.length;i++) {
            arr[i]=Caster.toString(array.get(i+1,""),"");
        }
        return arr;
    }


	public void createDirectory(boolean createParentWhenNotExists) throws IOException {
		ResourceUtil.checkCreateDirectoryOK(this, createParentWhenNotExists);
		try {
			provider.lock(this);
			s3.put(bucketName, objectName+"/", StreamWithSize.EMPTY);
		} catch (IOException ioe) {
			throw ioe;
		} catch (Exception e) {
			e.printStackTrace();
			throw new IOException(e.getMessage());
		} finally {
			provider.unlock(this);
		}
		s3.releaseCache(getInnerPath());
	}

	public void createFile(boolean createParentWhenNotExists) throws IOException {
		ResourceUtil.checkCreateFileOK(this, createParentWhenNotExists);
		if(isBucket()) {
			throw new IOException("can't create file ["+getPath()+"], on this level (Bucket Level) you can only create directories");
		}
		try {
			provider.lock(this);
			s3.put(bucketName, objectName, StreamWithSize.EMPTY);
		} catch (Exception e) {
			throw new IOException(e.getMessage());
		} finally {
			provider.unlock(this);
		}
		s3.releaseCache(getInnerPath());
	}

	public boolean exists() {
		return getInfo()
			.exists();
	}

	public InputStream getInputStream() throws IOException {
		ResourceUtil.checkGetInputStreamOK(this);
		provider.read(this);
		try {
			return Util.toBufferedInputStream(s3.getInputStream(bucketName, objectName));
		} catch (Exception e) {
			throw new IOException(e.getMessage());
		}
	}

	public int getMode() {
		return 777;
	}

	@Override
	public String getName() {
		if(isBucket()) {
			return bucketName;
		}
		return objectName.substring(objectName.lastIndexOf('/')+1);
	}

	@Override
	public boolean isAbsolute() {
		return true;
	}

	@Override
	public String getPath() {
		return getPrefix().concat(getInnerPath());
	}
	
	private String getPrefix()  {
		return provider.getScheme() + "://";
	}

	@Override
	public String getParent() {
		return getPrefix().concat(getInnerParent());
	}
	
	private String getInnerPath() {
		return ResourceUtil.translatePath(bucketName+"/"+objectName, true, false);
	}
	
	private String getInnerParent() {
		if(Util.isEmpty(objectName)) {
			return "/";
		}
		if(objectName.indexOf('/')==-1) {
			return "/"+bucketName;
		}
		String tmp=objectName.substring(0,objectName.lastIndexOf('/'));
		return ResourceUtil.translatePath(bucketName+"/"+tmp, true, false);
	}

	@Override
	public Resource getParentResource() {
		// MUST make more direct
		return new S3Resource(s3, isBucket()?S3.STORAGE_UNKNOWN :storage, provider, getInnerParent(), newPattern);
	}
	
	private boolean isBucket() {
		return bucketName!=null && Util.isEmpty(objectName);
	}

	@Override
	public String toString() {
		return getPath();
	}
	
	public OutputStream getOutputStream(boolean append) throws IOException {

		ResourceUtil.checkGetOutputStreamOK(this);
		
		try {
			byte[] barr = null;
			if(append){
				InputStream is=null;
				OutputStream os=null;
				try {
					ByteArrayOutputStream baos = new ByteArrayOutputStream();
					os=baos;
					is = getInputStream();
					Util.copy(is, baos);
					barr=baos.toByteArray();
				} catch (Exception e) {
					throw new PageRuntimeException(Caster.toPageException(e));
				} finally{
					Util.closeEL(is);
					Util.closeEL(os);
				}
			}
			S3ResourceOutputStream os = new S3ResourceOutputStream(s3,bucketName,objectName);
			if(append && !(barr==null || barr.length==0)){
				Util.copy(new ByteArrayInputStream(barr),os);
			}
			return os;
		} catch(IOException e) {
			throw e;
		} catch (Exception e) {
			throw new PageRuntimeException(Caster.toPageException(e));
		} finally {
			s3.releaseCache(getInnerPath());
		}
	}

	@Override
	public Resource getRealResource(String relpath) {
		relpath=ResourceUtil.merge(getInnerPath(), relpath);
		if(relpath.startsWith("../")) {
			return null;
		}
		return new S3Resource(s3, S3.STORAGE_UNKNOWN, provider, relpath, newPattern);
	}

	@Override
	public ResourceProvider getResourceProvider() {
		return provider;
	}

	@Override
	public boolean isDirectory() {
		return getInfo().isDirectory();
	}

	@Override
	public boolean isFile() {
		return getInfo().isFile();
	}

	public boolean isReadable() {
		return exists();
	}

	public boolean isWriteable() {
		return exists();
	}

	@Override
	public long lastModified() {
		return getInfo().getLastModified();
	}

	private S3Info getInfo() {
		S3Info info = s3.getInfo(getInnerPath());
		
		if(info==null) {
			try {
				provider.read(this);
			} catch (IOException e) {
				return LOCKED;
			}
			try {

				// todo Seems super inefficient!
				String path = objectName;
				Content[] contents = s3.listContents(bucketName, path);
				if(contents.length>0) {
					boolean has=false;
					for(int i=0;i<contents.length;i++) {
						if(ResourceUtil.translatePath(contents[i].getKey(),false,false).equals(path)) {
							has=true;
							info=contents[i];
							infoLastAccess=System.currentTimeMillis()+provider.getCache();
							break;
						}
					}
					// todo if this is folder?
					if(!has){
						for(int i=0;i<contents.length;i++) {
							if(ResourceUtil.translatePath(contents[i].getKey(),false,false).startsWith(path)) {
								info=UNDEFINED_WITH_CHILDREN;
								infoLastAccess=System.currentTimeMillis()+provider.getCache();
								break;
							}
						}
					}
				}

			if(info==null){
				info=UNDEFINED;
				infoLastAccess=System.currentTimeMillis()+provider.getCache();
			}
			}
			catch(Exception t) {
				return UNDEFINED;
			}
			s3.setInfo(getInnerPath(), info);
		}
		return info;
	}

	@Override
	public long length() {
		return getInfo().getSize();
	}

	public Resource[] listResources() {
		S3Resource[] children=null;
		try {
			Content[] contents = s3.listContents(bucketName, isBucket()?null:(objectName+"/"));
			ArrayList<S3Resource> tmp = new ArrayList<>();
			String key;
			String name;
			String path;
			int index;
			Set<String> names=new LinkedHashSet<>();
			Set<String> pathes=new LinkedHashSet<>();
			S3Resource r;
			boolean isb=isBucket();
			for(int i=0;i<contents.length;i++) {
				key=ResourceUtil.translatePath(contents[i].getKey(), false, false);
				if(!isb && !key.startsWith(objectName+"/")) {
					continue;
				}
				if(Util.isEmpty(key)) {
					continue;
				}
				index=key.indexOf('/',Util.length(objectName)+1);
				if(index==-1) {
					name=key;
					path=null;
				} else {
					name=key.substring(index+1);
					path=key.substring(0,index);
				}

				if(path==null){
					names.add(name);
					tmp.add(r = new S3Resource(s3,storage,provider,contents[i].getBucketName(),key,newPattern));
					s3.setInfo(r.getInnerPath(),contents[i]);
				} else {
					pathes.add(path);
				}
			}

			Iterator<String> it = pathes.iterator();
			while(it.hasNext()) {
				path=it.next();
				if(names.contains(path)) {
					continue;
				}
				tmp.add(r=new S3Resource(s3,storage,provider,bucketName,path,newPattern));
				s3.setInfo(r.getInnerPath(),UNDEFINED_WITH_CHILDREN2);
			}

			children=tmp.toArray(new S3Resource[tmp.size()]);
		} catch(Exception t) {
			t.printStackTrace();
			return null;
		}
		return children;
	}

	@Override
	public void remove(boolean force) throws IOException {
		ResourceUtil.checkRemoveOK(this);

		boolean isd=isDirectory();
		if(isd) {
			Resource[] children = listResources();
			if(children != null && children.length>0) {
				if(force) {
					for(int i=0;i<children.length;i++) {
						children[i].remove(force);
					}
				} else {
					throw new IOException("can not remove directory ["+this+"], directory is not empty");
				}
			}
		}
		// delete res itself
		provider.lock(this);
		try {
			s3.delete(bucketName, isd? (objectName+"/") :objectName);
		} catch (Exception e) {
			throw new IOException(e.getMessage());
		} finally {
			s3.releaseCache(getInnerPath());
			provider.unlock(this);
		}
	}

	public boolean setLastModified(long time) {
		s3.releaseCache(getInnerPath());
		// TODO Auto-generated method stub
		// todo, is this fine?
		return false;
	}

	public void setMode(int mode) throws IOException {
		s3.releaseCache(getInnerPath());
		// TODO Auto-generated method stub
	}

	public boolean setReadable(boolean readable) {
		s3.releaseCache(getInnerPath());
		// TODO Auto-generated method stub
		return false;
	}

	public boolean setWritable(boolean writable) {
		s3.releaseCache(getInnerPath());
		// TODO Auto-generated method stub
		return false;
	}

	public AccessControlPolicy getAccessControlPolicy() {
		// todo is this ok?
		throw new NotImplementedException();
	}
	
	public void setAccessControlPolicy(AccessControlPolicy acp) {
		// Not managing ACLs here
	}

	public void setACL(int acl) {
		// Not managing ACLs here
	}


	public void setStorage(int storage) {
		this.storage=storage;
	}

	private static class Dummy implements S3Info {

		private final long lastModified;
		private final long size;
		private final boolean exists;
		private final boolean file;
		private final boolean directory;
		private final String label;

		public Dummy(String label,long lastModified, long size, boolean exists,boolean file, boolean directory) {
			this.label = label;
			this.lastModified = lastModified;
			this.size = size;
			this.exists = exists;
			this.file = file;
			this.directory = directory;
		}

		@Override
		public long getLastModified() {
			return lastModified;
		}

		@Override
		public long getSize() {
			return size;
		}

		@Override
		public String toString() {
			return "Dummy:"+getLabel();
		}

		public String getLabel() {
			return label;
		}

		@Override
		public boolean exists() {
			return exists;
		}

		@Override
		public boolean isDirectory() {
			return directory;
		}

		@Override
		public boolean isFile() {
			return file;
		}

	}
}



