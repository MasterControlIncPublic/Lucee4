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

	        	// On Linux, resolve web-root-relative paths via servlet context rather than
	        	// treating /foo as an absolute filesystem path. Return unconditionally so
	        	// paths that don't exist yet (creation case) still get the correct base.
	        	if(!SystemUtil.isWindows() && !sources[0].exists()) {
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

        	// On Linux, resolve web-root-relative paths via servlet context rather than
        	// treating /foo as an absolute filesystem path (which it is on Linux — /foo
        	// is the literal Linux root, not <webroot>/foo). Return the web-root-resolved
        	// path unconditionally so callers get the right base even when the file does
        	// not exist yet (e.g. they are about to create it).
        	else if(!SystemUtil.isWindows()) {
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

    /**
     * Resolves a web-root-relative path (starting with /) against the servlet context's
     * real filesystem root. On Linux, paths starting with / are absolute filesystem paths,
     * so /services/Application resolves to the literal Linux path /services/Application
     * rather than <webroot>/services/Application. This helper fixes that by asking the
     * servlet container where / actually lives on disk.
     */
    private static Resource resolveWebRootRelative(PageContext pc, String relPath) {
        try {
            String webRoot = pc.getHttpServletRequest().getServletContext().getRealPath("/");
            if (webRoot == null || webRoot.isEmpty()) return null;
            // Strip leading slash before appending — Paths.get() treats a leading slash
            // on a second segment as "start over from root", discarding the webRoot prefix.
            String stripped = StringUtil.startsWith(relPath, '/') ? relPath.substring(1) : relPath;
            String resolved = Paths.get(webRoot, stripped).normalize().toString();
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

		// Normalize .. and . segments using Java NIO so that paths like
		// /services/Presentation/../Application resolve correctly on all platforms.
		if(path.contains("..") || path.contains("./")) {
			try {
				// Prefix a / so Paths.get() treats it as absolute for normalization purposes,
				// then restore the original prefix state afterwards.
				boolean hadLeadingSlash = path.startsWith("/");
				java.nio.file.Path nioPath = Paths.get(hadLeadingSlash ? path : "/" + path);
				String normalized = nioPath.normalize().toString().replace('\\', '/');
				if (!hadLeadingSlash && normalized.startsWith("/")) {
					normalized = normalized.substring(1);
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
	}
}
