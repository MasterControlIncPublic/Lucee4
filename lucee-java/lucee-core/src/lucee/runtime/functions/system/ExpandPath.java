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
/**
 * Implements the CFML Function expandpath
 */
package lucee.runtime.functions.system;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;

import lucee.commons.io.SystemUtil;
import lucee.commons.io.res.Resource;
import lucee.commons.io.res.ResourceProvider;
import lucee.commons.io.res.util.ResourceUtil;
import lucee.commons.lang.StringUtil;
import lucee.runtime.PageContext;
import lucee.runtime.PageContextImpl;
import lucee.runtime.PageSource;
import lucee.runtime.config.ConfigWeb;
import lucee.runtime.config.ConfigWebImpl;
import lucee.runtime.config.ConfigWebUtil;
import lucee.runtime.exp.PageException;
import lucee.runtime.ext.function.Function;
import lucee.runtime.type.util.ArrayUtil;

public final class ExpandPath implements Function {

	private static final long serialVersionUID = 6192659914120397912L;

	public static String call(PageContext pc , String relPath) throws PageException {
		ConfigWeb config=pc.getConfig();

		relPath=prettifyPath(pc,relPath);

        String contextPath = pc.getHttpServletRequest().getContextPath();
        if ( !StringUtil.isEmpty( contextPath ) && relPath.startsWith( contextPath ) ) {
            boolean sws=StringUtil.startsWith(relPath, '/');
        	relPath = relPath.substring( contextPath.length() );
            if(sws && !StringUtil.startsWith(relPath, '/'))
            	relPath="/"+relPath;
        }

        Resource res;

        if(StringUtil.startsWith(relPath,'/')) {

        	PageContextImpl pci=(PageContextImpl) pc;
        	ConfigWebImpl cwi=(ConfigWebImpl) config;
        	PageSource[] sources = cwi.getPageSources(pci, pc.getApplicationContext().getMappings(), relPath,
        			false, pci.useSpecialMappings(), true);

        	if(!ArrayUtil.isEmpty(sources)) {
        		// first check for existing
	        	for(int i=0;i<sources.length;i++){
	        		if(sources[i].exists()) {
	        			return toReturnValue(relPath,sources[i].getResource());
	        		}
	        	}

	        	if(!SystemUtil.isWindows() && !sources[0].exists()) { // Linux: /foo is absolute on the OS; fall back to explicit webroot-relative resolution
	        		res=pc.getConfig().getResource(relPath);
	        		if(res.exists()) return toReturnValue(relPath,res); // file already exists at this absolute path; return directly
	        		if(hasExistingAncestor(relPath)) return relPath; // ancestor dir exists on OS -> treat as real absolute path not yet created
	        		res=resolveWebRootRelative(pc, relPath);
                    if(res != null) {
                    	return toReturnValue(relPath,res);
                    }
	        	}
	        	for(int i=0;i<sources.length;i++){
	        		res=sources[i].getResource();
	        		if(res!=null) {
	        			return toReturnValue(relPath,res);
	        		}
	        	}
        	}

        	else if(!SystemUtil.isWindows()) { // Linux: no page sources found; resolve against webroot
        		res=pc.getConfig().getResource(relPath);
        		if(res.exists()) return toReturnValue(relPath,res); // file already exists at this absolute path; return directly
        		if(hasExistingAncestor(relPath)) return relPath; // ancestor dir exists on OS -> treat as real absolute path not yet created
        		res=resolveWebRootRelative(pc, relPath);
                if(res != null) {
                	return toReturnValue(relPath,res);
                }
        	}


        	//Resource[] reses = cwi.getPhysicalResources(pc,pc.getApplicationContext().getMappings(),relPath,false,pci.useSpecialMappings(),true);

        }
        relPath=ConfigWebUtil.replacePlaceholder(relPath, config);
        res=pc.getConfig().getResource(relPath);
        if(res.isAbsolute()) return toReturnValue(relPath,res);

        res=ResourceUtil.getResource(pc,pc.getBasePageSource());
        if(!res.isDirectory())res=res.getParentResource();
        res = res.getRealResource(relPath);
        return toReturnValue(relPath,res);

	}

    /**
     * Walk ancestors of path using Java NIO (real OS filesystem, not Lucee's virtual resource
     * mapping). Returns true if any ancestor directory exists and is not the filesystem root "/".
     * This distinguishes real absolute OS paths like /opt/myapp/config/app.conf
     * (whose ancestor /opt/myapp/config exists) from short webroot-relative paths
     * like /nonexistent_xyz (whose only ancestor is "/").
     */
    private static boolean hasExistingAncestor(String path) {
        java.nio.file.Path p = Paths.get(path).getParent();
        while (p != null && p.getNameCount() > 0) { // getNameCount()==0 means we have reached the fs root "/"
            if (Files.exists(p)) return true;
            p = p.getParent();
        }
        return false;
    }

    private static String toReturnValue(String relPath,Resource res) {
        String path;
        char pathChar='/';
        try {
            path=res.getCanonicalPath();
            pathChar=ResourceUtil.FILE_SEPERATOR;
        } catch (IOException e) {
            path= res.getAbsolutePath();
        }
        boolean pathEndsWithSep=StringUtil.endsWith(path,pathChar);
        boolean realEndsWithSep=StringUtil.endsWith(relPath,'/');

        if(realEndsWithSep) {
            if(!pathEndsWithSep)path=path+pathChar;
        }
        else if(pathEndsWithSep) {
            path=path.substring(0,path.length()-1);
        }

        return path;
    }

    private static Resource resolveWebRootRelative(PageContext pc, String relPath) {
        try {
            String webRoot = pc.getHttpServletRequest().getServletContext().getRealPath("/"); // filesystem path of the servlet web root
            if (webRoot == null || webRoot.isEmpty()) return null;
            String stripped = StringUtil.startsWith(relPath, '/') ? relPath.substring(1) : relPath; // strip leading slash so it joins as a relative segment
            String resolved = Paths.get(webRoot, stripped).normalize().toString(); // join webroot + path and collapse any .. segments
            return pc.getConfig().getResource(resolved);
        } catch (Exception e) {
            return null;
        }
    }

    private static String prettifyPath(PageContext pc, String path) {
		if(path==null) return null;

		// UNC Path
		if(path.startsWith("\\\\") && SystemUtil.isWindows()) {
			path=path.substring(2);
			path=path.replace('\\','/');
			return "//"+StringUtil.replace(path, "//", "/", false);
		}

		path=path.replace('\\','/');

		if(path.contains("..") || path.contains("./")) {
			try {
				boolean hadLeadingSlash = path.startsWith("/"); // remember if path was absolute before normalization
				boolean hadTrailingSlash = path.endsWith("/"); // normalize() drops trailing slash; preserve it so callers that append paths get the separator
				String normalized = Paths.get(path).normalize().toString().replace('\\', '/'); // use path as-is — prefixing '/' would clamp '../../' to filesystem root
				if (hadLeadingSlash && !normalized.startsWith("/")) { // restore leading slash if normalize() dropped it (Windows behavior)
					normalized = "/" + normalized;
				}
				if (hadTrailingSlash && !normalized.endsWith("/")) {
					normalized = normalized + "/";
				}
				path = normalized;
			} catch (Exception e) {
				// Fall through to string-based cleanup below
			}
		}

		// virtual file system path
		int index=path.indexOf("://");
		if(index!=-1) {
			ResourceProvider[] providers = pc.getConfig().getResourceProviders();
			String scheme=path.substring(0,index).toLowerCase().trim();
			for(int i=0;i<providers.length;i++) {
				if(scheme.equalsIgnoreCase(providers[i].getScheme()))
					return scheme+"://"+StringUtil.replace(path.substring(index+3), "//", "/", false);
			}
		}

		return StringUtil.replace(path, "//", "/", false);
		// TODO /aaa/../bbb/
	}
}
