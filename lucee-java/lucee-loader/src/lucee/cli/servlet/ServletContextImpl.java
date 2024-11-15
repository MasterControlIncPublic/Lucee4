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
package lucee.cli.servlet;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.Enumeration;
import java.util.Map;
import java.util.Set;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.Servlet;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;

import lucee.cli.util.EnumerationWrapper;

public class ServletContextImpl implements ServletContext {
	private Map<String,Object> attributes;
	private Map<String, String> parameters;
	private int majorVersion;
	private int minorVersion;
	private File root;
	
	
	public ServletContextImpl(File root,Map<String,Object> attributes,Map<String, String> parameters,int majorVersion, int minorVersion) {
		this.root=root;
		this.attributes=attributes;
		this.parameters=parameters;
		this.majorVersion=majorVersion;
		this.minorVersion=minorVersion;
	}

	/**
	 * @see jakarta.servlet.ServletContext#getAttribute(java.lang.String)
	 */
	public Object getAttribute(String key) {
		return attributes.get(key);
	}

	/**
	 * @see jakarta.servlet.ServletContext#getAttributeNames()
	 */
	public Enumeration getAttributeNames() {
		return new EnumerationWrapper(attributes);
	}
	
	/**
	 * @see jakarta.servlet.ServletContext#getInitParameter(java.lang.String)
	 */
	public String getInitParameter(String key) {
		return parameters.get(key);
	}

	/**
	 * @see jakarta.servlet.ServletContext#getInitParameterNames()
	 */
	public Enumeration getInitParameterNames() {
		return new EnumerationWrapper(parameters);
	}

	/**
	 * @see jakarta.servlet.ServletContext#getMajorVersion()
	 */
	public int getMajorVersion() {
		return majorVersion;
	}

	/**
	 * @see jakarta.servlet.ServletContext#getMinorVersion()
	 */
	public int getMinorVersion() {
		return minorVersion;
	}

	/**
	 * @see jakarta.servlet.ServletContext#getMimeType(java.lang.String)
	 */
	public String getMimeType(String file) {
		throw notSupported("getMimeType(String file)");
		// TODO
		//return ResourceUtil.getMimeType(config.getResource(file),null);
	}

	@Override
	public String getRealPath(String relpath) {
		return getRealFile(relpath).getAbsolutePath();
	}

	/**
	 * @see jakarta.servlet.ServletContext#getResource(java.lang.String)
	 */
	public URL getResource(String relpath) throws MalformedURLException {
		File file = getRealFile(relpath);
		return file.toURL();
	}

	/**
	 * @see jakarta.servlet.ServletContext#getResourceAsStream(java.lang.String)
	 */
	public InputStream getResourceAsStream(String relpath) {
		try {
			return new FileInputStream(getRealFile(relpath));
		} catch (IOException e) {
			return null;
		}
	}

	public File getRealFile(String relpath) {
		return new File(root,relpath);
	}

	public File getRoot() {
		return root;
	}

	public Set getResourcePaths(String relpath) {
		throw notSupported("getResourcePaths(String relpath)");
	}

	public RequestDispatcher getRequestDispatcher(String path) {
		throw notSupported("getNamedDispatcher(String name)");
	}

	public ServletContext getContext(String key) {
		// TODO ?
		return this;
	}

	public RequestDispatcher getNamedDispatcher(String name) {
		// TODO Auto-generated method stub
		throw notSupported("getNamedDispatcher(String name)");
	}

	/**
	 * @see jakarta.servlet.ServletContext#log(java.lang.String, java.lang.Throwable)
	 */
	public void log(String msg, Throwable t) {// TODO better
		if(t==null)System.out.println(msg);
		else System.out.println(msg+":\n"+t.getMessage());
	
		
		//if(t==null)log.log(Log.LEVEL_INFO, "ServletContext", msg);
		//else log.log(Log.LEVEL_ERROR, "ServletContext", msg+":\n"+ExceptionUtil.getStacktrace(t,false));
	}

	/**
	 * @see jakarta.servlet.ServletContext#log(java.lang.Exception, java.lang.String)
	 */
	public void log(Exception e, String msg) {
		log(msg,e);
	}

	/**
	 * @see jakarta.servlet.ServletContext#log(java.lang.String)
	 */
	public void log(String msg) {
		log(msg,null);
	}

	/**
	 * @see jakarta.servlet.ServletContext#removeAttribute(java.lang.String)
	 */
	public void removeAttribute(String key) {
		attributes.remove(key);
	}

	/**
	 * @see jakarta.servlet.ServletContext#setAttribute(java.lang.String, java.lang.Object)
	 */
	public void setAttribute(String key, Object value) {
		attributes.put(key, value);
	}
	
	


	public String getServletContextName() {
		// can return null
		return null;
	}

	public String getServerInfo() {
		// deprecated
		throw notSupported("getServlet()");
	}

	public Servlet getServlet(String arg0) throws ServletException {
		// deprecated
		throw notSupported("getServlet()");
	}

	public Enumeration getServletNames() {
		// deprecated
		throw notSupported("getServlet()");
	}

	public Enumeration getServlets() {
		// deprecated
		throw notSupported("getServlet()");
	}

	private RuntimeException notSupported(String method) {
		throw new RuntimeException(new ServletException("method "+method+" not supported"));
	}

}
