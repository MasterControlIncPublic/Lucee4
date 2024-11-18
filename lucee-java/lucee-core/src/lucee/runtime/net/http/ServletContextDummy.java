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
package lucee.runtime.net.http;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.Enumeration;
import java.util.EventListener;
import java.util.Map;
import java.util.Set;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterRegistration;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.Servlet;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;

import jakarta.servlet.ServletRegistration;
import jakarta.servlet.SessionCookieConfig;
import jakarta.servlet.SessionTrackingMode;
import jakarta.servlet.descriptor.JspConfigDescriptor;
import lucee.commons.io.log.log4j.Log4jUtil;
import lucee.commons.io.res.Resource;
import lucee.commons.io.res.util.ResourceUtil;
import lucee.runtime.config.Config;
import lucee.runtime.op.Caster;
import lucee.runtime.type.KeyImpl;
import lucee.runtime.type.Struct;
import lucee.runtime.type.it.ItAsEnum;
import lucee.runtime.util.EnumerationWrapper;

import org.apache.log4j.Level;
import org.apache.log4j.Logger;

public class ServletContextDummy implements ServletContext {
	private Struct attributes;
	private Struct parameters;
	private int majorVersion;
	private int minorVersion;
	private Config config;
	private Logger log;
	private Resource root;
	
	
	public ServletContextDummy(Config config,Resource root,Struct attributes,Struct parameters,int majorVersion, int minorVersion) {
		this.config=config;
		this.root=root;
		this.attributes=attributes;
		this.parameters=parameters;
		this.majorVersion=majorVersion;
		this.minorVersion=minorVersion;
		log=Log4jUtil.getConsoleLog(config, false,"servlet-context-dummy",Level.INFO);
		
	}

	@Override
	public Object getAttribute(String key) {
		return attributes.get(key,null);
	}

	@Override
	public Enumeration getAttributeNames() {
		return ItAsEnum.toStringEnumeration(attributes.keyIterator());
	}
	
	@Override
	public String getInitParameter(String key) {
		return Caster.toString(parameters.get(key,null),null);
	}

	@Override
	public Enumeration getInitParameterNames() {
		return new EnumerationWrapper(parameters.keyIterator());
	}

	@Override
	public boolean setInitParameter(String s, String s1) {
		return false;
	}

	@Override
	public int getMajorVersion() {
		return majorVersion;
	}

	@Override
	public int getMinorVersion() {
		return minorVersion;
	}

	@Override
	public int getEffectiveMajorVersion() {
		return 0;
	}

	@Override
	public int getEffectiveMinorVersion() {
		return 0;
	}

	@Override
	public String getMimeType(String file) {
		return ResourceUtil.getMimeType(config.getResource(file),null);
	}

	@Override
	public String getRealPath(String relpath) {
		return root.getRealResource(relpath).getAbsolutePath();
	}

	@Override
	public URL getResource(String relpath) throws MalformedURLException {
		Resource res = getRealResource(relpath);
		if(res instanceof File)return ((File)res).toURL();
		return new URL(res.getAbsolutePath());
	}

	@Override
	public InputStream getResourceAsStream(String relpath) {
		try {
			return getRealResource(relpath).getInputStream();
		} catch (IOException e) {
			return null;
		}
	}

	public Resource getRealResource(String relpath) {
		return root.getRealResource(relpath);
	}

	public Set getResourcePaths(String relpath) {
		// TODO Auto-generated method stub
		return null;
	}

	public RequestDispatcher getRequestDispatcher(String path) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String getContextPath() {
		return "";
	}

	public ServletContext getContext(String key) {
		// TODO ?
		return this;
	}

	public RequestDispatcher getNamedDispatcher(String name) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void log(String msg, Throwable t) {
		if(t==null)log.log(Level.INFO,msg);
		else log.log(Level.ERROR, msg,t);
	}

	@Override
	public void log(Exception e, String msg) {
		log(msg,e);
	}

	@Override
	public void log(String msg) {
		log(msg,null);
	}

	@Override
	public void removeAttribute(String key) {
		attributes.removeEL(KeyImpl.init(key));
	}

	@Override
	public void setAttribute(String key, Object value) {
		attributes.setEL(KeyImpl.init(key), value);
	}
	
	


	public String getServletContextName() {
		// can return null
		return null;
	}

	@Override
	public ServletRegistration.Dynamic addServlet(String s, String s1) {
		return null;
	}

	@Override
	public ServletRegistration.Dynamic addServlet(String s, Servlet servlet) {
		return null;
	}

	@Override
	public ServletRegistration.Dynamic addServlet(String s, Class<? extends Servlet> aClass) {
		return null;
	}

	@Override
	public ServletRegistration.Dynamic addJspFile(String s, String s1) {
		return null;
	}

	@Override
	public <T extends Servlet> T createServlet(Class<T> aClass) throws ServletException {
		return null;
	}

	@Override
	public ServletRegistration getServletRegistration(String s) {
		return null;
	}

	@Override
	public Map<String, ? extends ServletRegistration> getServletRegistrations() {
		return Map.of();
	}

	@Override
	public FilterRegistration.Dynamic addFilter(String s, String s1) {
		return null;
	}

	@Override
	public FilterRegistration.Dynamic addFilter(String s, Filter filter) {
		return null;
	}

	@Override
	public FilterRegistration.Dynamic addFilter(String s, Class<? extends Filter> aClass) {
		return null;
	}

	@Override
	public <T extends Filter> T createFilter(Class<T> aClass) throws ServletException {
		return null;
	}

	@Override
	public FilterRegistration getFilterRegistration(String s) {
		return null;
	}

	@Override
	public Map<String, ? extends FilterRegistration> getFilterRegistrations() {
		return Map.of();
	}

	@Override
	public SessionCookieConfig getSessionCookieConfig() {
		return null;
	}

	@Override
	public void setSessionTrackingModes(Set<SessionTrackingMode> set) {

	}

	@Override
	public Set<SessionTrackingMode> getDefaultSessionTrackingModes() {
		return Set.of();
	}

	@Override
	public Set<SessionTrackingMode> getEffectiveSessionTrackingModes() {
		return Set.of();
	}

	@Override
	public void addListener(String s) {

	}

	@Override
	public <T extends EventListener> void addListener(T t) {

	}

	@Override
	public void addListener(Class<? extends EventListener> aClass) {

	}

	@Override
	public <T extends EventListener> T createListener(Class<T> aClass) throws ServletException {
		return null;
	}

	@Override
	public JspConfigDescriptor getJspConfigDescriptor() {
		return null;
	}

	@Override
	public ClassLoader getClassLoader() {
		return null;
	}

	@Override
	public void declareRoles(String... strings) {

	}

	@Override
	public String getVirtualServerName() {
		return "";
	}

	@Override
	public int getSessionTimeout() {
		return 0;
	}

	@Override
	public void setSessionTimeout(int i) {

	}

	@Override
	public String getRequestCharacterEncoding() {
		return "";
	}

	@Override
	public void setRequestCharacterEncoding(String s) {

	}

	@Override
	public String getResponseCharacterEncoding() {
		return "";
	}

	@Override
	public void setResponseCharacterEncoding(String s) {

	}

	public String getServerInfo() {
		// deprecated
		return null;
	}

	public Servlet getServlet(String arg0) throws ServletException {
		// deprecated
		return null;
	}

	public Enumeration getServletNames() {
		// deprecated
		return null;
	}

	public Enumeration getServlets() {
		// deprecated
		return null;
	}

}
