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
package lucee.runtime.config;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import javax.servlet.ServletException;

import lucee.commons.digest.MD5;
import lucee.commons.io.FileUtil;
import lucee.commons.io.IOUtil;
import lucee.commons.io.SystemUtil;
import lucee.commons.io.cache.Cache;
import lucee.commons.io.log.log4j.appender.ConsoleAppender;
import lucee.commons.io.log.log4j.appender.RollingResourceAppender;
import lucee.commons.io.log.log4j.layout.ClassicLayout;
import lucee.commons.io.res.Resource;
import lucee.commons.io.res.ResourceProvider;
import lucee.commons.io.res.filter.ResourceNameFilter;
import lucee.commons.io.res.type.s3.S3ResourceProvider;
import lucee.commons.io.res.util.ResourceUtil;
import lucee.commons.lang.ClassException;
import lucee.commons.lang.ClassUtil;
import lucee.commons.lang.StringUtil;
import lucee.commons.lang.SystemOut;
import lucee.commons.net.HTTPUtil;
import lucee.commons.net.IPRange;
import lucee.commons.net.URLEncoder;
import lucee.commons.net.http.HTTPEngine;
import lucee.commons.net.http.HTTPResponse;
import lucee.loader.engine.CFMLEngineFactory;
import lucee.loader.util.ExtensionFilter;
import lucee.runtime.Info;
import lucee.runtime.PageContext;
import lucee.runtime.cache.CacheConnection;
import lucee.runtime.cache.eh.EHCache;
import lucee.runtime.cfx.CFXTagException;
import lucee.runtime.cfx.CFXTagPool;
import lucee.runtime.converter.ConverterException;
import lucee.runtime.converter.WDDXConverter;
import lucee.runtime.db.DataSource;
import lucee.runtime.exp.ApplicationException;
import lucee.runtime.exp.ExpressionException;
import lucee.runtime.exp.HTTPException;
import lucee.runtime.exp.PageException;
import lucee.runtime.exp.SecurityException;
import lucee.runtime.extension.Extension;
import lucee.runtime.extension.RHExtension;
import lucee.runtime.functions.cache.Util;
import lucee.runtime.functions.other.CreateObject;
import lucee.runtime.functions.other.CreateUUID;
import lucee.runtime.functions.other.URLEncodedFormat;
import lucee.runtime.functions.string.Hash;
import lucee.runtime.gateway.GatewayEntry;
import lucee.runtime.gateway.GatewayEntryImpl;
import lucee.runtime.listener.AppListenerUtil;
import lucee.runtime.op.Caster;
import lucee.runtime.op.Decision;
import lucee.runtime.orm.ORMConfiguration;
import lucee.runtime.orm.ORMConfigurationImpl;
import lucee.runtime.reflection.Reflector;
import lucee.runtime.security.SecurityManager;
import lucee.runtime.security.SecurityManagerImpl;
import lucee.runtime.security.SerialNumber;
import lucee.runtime.text.xml.XMLCaster;
import lucee.runtime.text.xml.XMLUtil;
import lucee.runtime.type.Array;
import lucee.runtime.type.ArrayImpl;
import lucee.runtime.type.Collection.Key;
import lucee.runtime.type.KeyImpl;
import lucee.runtime.type.Query;
import lucee.runtime.type.QueryImpl;
import lucee.runtime.type.Struct;
import lucee.runtime.type.dt.TimeSpan;
import lucee.runtime.type.scope.Cluster;
import lucee.runtime.type.scope.ClusterNotSupported;
import lucee.runtime.type.scope.ClusterRemote;
import lucee.runtime.type.scope.ScopeContext;
import lucee.runtime.type.util.ArrayUtil;
import lucee.runtime.type.util.ComponentUtil;
import lucee.runtime.type.util.ListUtil;
import lucee.runtime.video.VideoExecuter;
import lucee.runtime.video.VideoExecuterNotSupported;
import lucee.transformer.library.function.FunctionLibException;
import lucee.transformer.library.tag.TagLibException;

import org.apache.log4j.HTMLLayout;
import org.apache.log4j.Level;
import org.apache.log4j.PatternLayout;
import org.apache.log4j.xml.XMLLayout;
import org.apache.xerces.parsers.DOMParser;
import org.w3c.dom.DOMException;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

import com.allaire.cfx.CustomTag;

/**
 * 
 */
public final class ConfigWebAdmin {
    
    //private static final Object NULL = new Object();
	private ConfigImpl config;
    private Document doc;
	private String password;
    //private SecurityManager accessorx;


    /**
     * 
     * @param config
     * @param password
     * @return returns a new instance of the class
     * @throws SAXException
     * @throws IOException
     */
    public static ConfigWebAdmin newInstance(ConfigImpl config, String password) throws SAXException, IOException {
        return new ConfigWebAdmin(config, password);
    }
    

    private void checkWriteAccess() throws SecurityException {
    	ConfigWebUtil.checkGeneralWriteAccess(config,password);
	}
    private void checkReadAccess() throws SecurityException {
    	ConfigWebUtil.checkGeneralReadAccess(config,password);
	}
    
    /**
     * @param password
     * @throws IOException 
     * @throws DOMException 
     * @throws ExpressionException 
     */
    public void setPassword(Password password) throws SecurityException, DOMException, IOException {
    	checkWriteAccess();
    	Password.store(doc.getDocumentElement(), password, false);
    }

    public void setVersion(double version) {
    	setVersion(doc,version);
        
    }
    public static void setVersion(Document doc,double version) {
    	Element root=doc.getDocumentElement();
    	String str = Caster.toString(version);
    	if(str.length()>3)str=str.substring(0,3);
        root.setAttribute("version",str); 
        
    }
    /*public void setId(String id) {
    	
    	Element root=doc.getDocumentElement();
    	if(!StringUtil.isEmpty(root.getAttribute("id"))) return;
    	root.setAttribute("id",id); 
    	try {
			store(config);
		} 
    	catch (Exception e) {}
    }*/
    
    /**
     * @param contextPath
     * @param password
     * @throws FunctionLibException
     * @throws TagLibException
     * @throws IOException
     * @throws ClassNotFoundException
     * @throws SAXException
     * @throws PageException
     */
    public void removePassword(String contextPath) throws PageException, SAXException, ClassException, IOException, TagLibException, FunctionLibException {
    	checkWriteAccess();
    	if(contextPath==null || contextPath.length()==0 || !(config instanceof ConfigServerImpl)) {
    		// config.setPassword(password); do nothing!
        }
        else { 
            ConfigServerImpl cs=(ConfigServerImpl)config;
            ConfigWebImpl cw=cs.getConfigWebImpl(contextPath);
            if(cw!=null)cw.updatePassword(false,cw.getPassword(),null);
        }
    }
    
    private ConfigWebAdmin(ConfigImpl config, String password) throws SAXException, IOException {
    	this.config=config;
    	this.password=password;
        doc=loadDocument(config.getConfigFile());
        //setId(config.getId());
    } 
    
    public static void checkForChangesInConfigFile(Config config) {
    	ConfigImpl ci=(ConfigImpl) config;
		if(!ci.checkForChangesInConfigFile()) return;
		
		Resource file = config.getConfigFile();
		long diff=file.lastModified()-ci.lastModified();
		if(diff<10 && diff>-10) return; 
		// reload
		try {
			ConfigWebAdmin admin = ConfigWebAdmin.newInstance(ci, null);
			admin.reload(ci, false);
			SystemOut.printDate(ci.getOutWriter(), "reloaded the configuration ["+file+"] automaticly");
		} 
		catch (Throwable t) {
			t.printStackTrace();
		}
	}
    
    

    private void addResourceProvider(String scheme,String clazz,String arguments) throws SecurityException {
    	checkWriteAccess();
    	
        Element resources=_getRootElement("resources");
        Element[] rpElements = ConfigWebFactory.getChildren(resources,"resource-provider");
      	String s;
        // update
        if(rpElements!=null) {
        	for(int i=0;i<rpElements.length;i++) {
        		s=rpElements[i].getAttribute("scheme");
        		if(!StringUtil.isEmpty(s) && s.equalsIgnoreCase(scheme))	{
        			rpElements[i].setAttribute("class", clazz);
        			rpElements[i].setAttribute("scheme", scheme);
        			rpElements[i].setAttribute("arguments", arguments);
        			return;
        		}
        	}
        }
        // Insert
    	Element el=doc.createElement("resource-provider");
    	resources.appendChild(XMLCaster.toRawNode(el));
    	el.setAttribute("class", clazz);
    	el.setAttribute("scheme", scheme);
    	el.setAttribute("arguments", arguments);
	}


	/**
     * load XML Document from XML File
     * @param config
     * @param xmlFile XML File to read
     * @return returns the Document
     * @throws SAXException
     * @throws IOException
     */
    private static Document loadDocument(Resource xmlFile) throws SAXException, IOException {
        DOMParser parser = new DOMParser();
        InputStream is=null;
        try {
        	is = IOUtil.toBufferedInputStream(xmlFile.getInputStream());
    	    InputSource source = new InputSource(is);
    	    parser.parse(source);
        }
        finally {
        	IOUtil.closeEL(is);
        }
	    return parser.getDocument();
    }
    
    private static synchronized void _store(ConfigImpl config) throws PageException, SAXException, ClassException, IOException, TagLibException, FunctionLibException  {
    	ConfigWebAdmin admin = new ConfigWebAdmin(config, null);
    	admin._reload(config, true);
    }

    private synchronized void _store() throws PageException, SAXException, ClassException, IOException, TagLibException, FunctionLibException  {
    	_reload(config, true);
    }
    
    public synchronized void store() throws PageException, SAXException, ClassException, IOException, TagLibException, FunctionLibException  {
    	reload(config, true);
    }
    
    private synchronized void reload(ConfigImpl config, boolean storeInMemoryData) throws PageException, SAXException, ClassException, IOException, TagLibException, FunctionLibException  {
    	if(storeInMemoryData)checkWriteAccess();
    	_reload(config, storeInMemoryData);
    }

    private synchronized void _reload(ConfigImpl config, boolean storeInMemoryData) throws PageException, SAXException, ClassException, IOException, TagLibException, FunctionLibException  {
    	renameOldstyleCFX();
    	
    	createAbort();
        if(config instanceof ConfigServerImpl) {
        	if(storeInMemoryData)XMLCaster.writeTo(doc,config.getConfigFile());
            
            ConfigServerImpl cs=(ConfigServerImpl) config;
            ConfigServerFactory.reloadInstance(cs);
            ConfigWeb[] webs=cs.getConfigWebs();
            for(int i=0;i<webs.length;i++) {
                ConfigWebFactory.reloadInstance((ConfigServerImpl) config,(ConfigWebImpl)webs[i],true);
            }
        }
        else {
        	if(storeInMemoryData)XMLCaster.writeTo(doc,config.getConfigFile());
            //SystemUtil.sleep(10);
            ConfigServerImpl cs=((ConfigWebImpl)config).getConfigServerImpl();
            
            ConfigWebFactory.reloadInstance(cs,(ConfigWebImpl)config,false);
        }
    }
    
    
    

    private void createAbort() {
    	try {
	    	ConfigWebFactory.getChildByName(doc.getDocumentElement(),"cfabort",true);
    	}
    	catch(Throwable t) {}
    }


	public void setTaskMaxThreads(Integer maxThreads) throws SecurityException {
		checkWriteAccess();
    	boolean hasAccess=ConfigWebUtil.hasAccess(config,SecurityManager.TYPE_SETTING);
        if(!hasAccess)
            throw new SecurityException("no access to update task settings");
        Element mail=_getRootElement("remote-clients");
        mail.setAttribute("max-threads",Caster.toString(maxThreads,""));
	}

	/**
     * sets Mail Logger to Config
     * @param logFile
     * @param level 
     * @throws PageException 
     */
    public void setMailLog(String logFile, String level) throws PageException {
    	checkWriteAccess();
    	boolean hasAccess=ConfigWebUtil.hasAccess(config,SecurityManager.TYPE_MAIL);
        
        if(!hasAccess)
            throw new SecurityException("no access to update mail server settings");
        ConfigWebUtil.getFile(config,config.getRootDirectory(),logFile,FileUtil.TYPE_FILE);
        
        
        Element logging = ConfigWebFactory.getChildByName(doc.getDocumentElement(), "logging");
		Element[] children = XMLUtil.getChildElementsAsArray(logging);
		Element logger=null;
    	
		for(int i=0;i<children.length;i++){
			if(children[i].getTagName().equals("logger") && "mail".equalsIgnoreCase(children[i].getAttribute("name"))) {
				logger=children[i];
				break;
			}
		}
		if(logger==null) {
			logger = doc.createElement("logger");
			logging.appendChild(logger);
		}
		logger.setAttribute("name", "mail");
    	if("console".equalsIgnoreCase(logFile)) {
	    	logger.setAttribute("appender", "console");
    		logger.setAttribute("layout", "pattern");
    	}
    	else {
	    	logger.setAttribute("appender", "resource");
	    	logger.setAttribute("appender-arguments", "path:"+logFile);
    		logger.setAttribute("layout", "classic");
		}
    	logger.setAttribute("log-level",level);
    }

    /**
     * sets if spool is enable or not
     * @param spoolEnable
     * @throws SecurityException
     */
    public void setMailSpoolEnable(Boolean spoolEnable) throws SecurityException {
    	checkWriteAccess();
    	boolean hasAccess=ConfigWebUtil.hasAccess(config,SecurityManager.TYPE_MAIL);
        
      	if(!hasAccess)
            throw new SecurityException("no access to update mail server settings");
        Element mail=_getRootElement("mail");
        mail.setAttribute("spool-enable",Caster.toString(spoolEnable,""));
        //config.setMailSpoolEnable(spoolEnable);
    }
    
    

    /* *
     * sets if er interval is enable or not
     * @param interval
     * @throws SecurityException
     * /
    public void setMailSpoolInterval(Integer interval) throws SecurityException {
    	checkWriteAccess();
    	boolean hasAccess=ConfigWebUtil.hasAccess(config,SecurityManager.TYPE_MAIL);
        if(!hasAccess)
            throw new SecurityException("no access to update mail server settings");
        Element mail=_getRootElement("mail");
        mail.setAttribute("spool-interval",Caster.toString(interval,""));
        //config.setMailSpoolInterval(interval);
    }*/

    /**
     * sets the timeout for the spooler for one job
     * @param timeout
     * @throws SecurityException
     */
    public void setMailTimeout(Integer timeout) throws SecurityException {
    	checkWriteAccess();
    	boolean hasAccess=ConfigWebUtil.hasAccess(config,SecurityManager.TYPE_MAIL);
        if(!hasAccess)
            throw new SecurityException("no access to update mail server settings");
        Element mail=_getRootElement("mail");
        mail.setAttribute("timeout",Caster.toString(timeout,""));
        //config.setMailTimeout(timeout);
    }
    
    /**
     * sets the charset for the mail
     * @param timeout
     * @throws SecurityException
     */
    public void setMailDefaultCharset(String charset) throws PageException {
    	checkWriteAccess();
    	boolean hasAccess = ConfigWebUtil.hasAccess(config, SecurityManager.TYPE_MAIL);
    	if(!hasAccess) throw new SecurityException("no access to update mail server settings");
        
    	if(!StringUtil.isEmpty(charset)){
			try {
				IOUtil.checkEncoding(charset);
			} catch (IOException e) {
				throw Caster.toPageException(e);
			}
    	}
    	
		Element mail=_getRootElement("mail");
        mail.setAttribute("default-encoding",charset);
        //config.setMailDefaultEncoding(charset);		
	}

	/**
     * insert or update a mailserver on system
     * @param hostName
     * @param username
     * @param password
     * @param port
	 * @param ssl 
	 * @param tls 
     * @throws PageException 
     */
    public void updateMailServer(String hostName,String username,String password, int port, boolean tls, boolean ssl,long lifeTimeSpan, long idleTimeSpan) throws PageException {
    	checkWriteAccess();
    	boolean hasAccess=ConfigWebUtil.hasAccess(config,SecurityManager.TYPE_MAIL);
        if(!hasAccess)
            throw new SecurityException("no access to update mail server settings");
        
        /*try {
            SMTPVerifier.verify(hostName,username,password,port);
        } catch (SMTPException e) {
            throw Caster.toPageException(e);
        }*/
        
        Element mail=_getRootElement("mail");
        if(port<1) port=21;

        if(hostName==null || hostName.trim().length()==0)
            throw new ExpressionException("Host (SMTP) can be a empty value");
        hostName=hostName.trim();
        
        
        Element[] children = ConfigWebFactory.getChildren(mail,"server");
      	
        // Update
        Element server=null;
        for(int i=0;i<children.length;i++) {
      	    Element el=children[i];
      	    String smtp=el.getAttribute("smtp");
  			if(smtp!=null && smtp.equalsIgnoreCase(hostName)) {
	      		server=el;
	      		break;
  			}
      	}
        
        // Insert
      	if(server==null) {
      		server = doc.createElement("server");
      		mail.appendChild(XMLCaster.toRawNode(server));
      	}
      	server.setAttribute("smtp",hostName);
      	server.setAttribute("username",username);
      	server.setAttribute("password",ConfigWebFactory.encrypt(password));
      	server.setAttribute("port",Caster.toString(port));
      	server.setAttribute("tls",Caster.toString(tls));
      	server.setAttribute("ssl",Caster.toString(ssl));
      	server.setAttribute("life",Caster.toString(lifeTimeSpan));
      	server.setAttribute("idle",Caster.toString(idleTimeSpan));
      	
    }

    /**
     *removes a mailserver from system
     * @param hostName
     * @throws SecurityException 
     */
    public void removeMailServer(String hostName) throws SecurityException {
    	checkWriteAccess();
    	
        Element mail=_getRootElement("mail");
        Element[] children = ConfigWebFactory.getChildren(mail,"server");
        if(children.length>0) {
	      	for(int i=0;i<children.length;i++) {
	      	    Element el=children[i];
	      	    String smtp=el.getAttribute("smtp");
	  			if(smtp!=null && smtp.equalsIgnoreCase(hostName)) {
		      		mail.removeChild(children[i]);
	  			}
	      	}
        }
    }

	
	public void removeLogSetting(String name) throws SecurityException {
		checkWriteAccess();
    	Element logging=_getRootElement("logging");
        Element[] children = ConfigWebFactory.getChildren(logging,"logger");
        if(children.length>0) {
        	String _name;
	      	for(int i=0;i<children.length;i++) {
	      		Element el=children[i];
	      		_name=el.getAttribute("name");
	      		
	  			if(_name!=null && _name.equalsIgnoreCase(name)) {
	  				logging.removeChild(children[i]);
	  			}
	      	}
        }
	}
    
    static void updateMapping(ConfigImpl config, String virtual, String physical,String archive,String primary, short inspect, boolean toplevel) throws SAXException, IOException, PageException {
    	ConfigWebAdmin admin = new ConfigWebAdmin(config, null);
    	admin._updateMapping(virtual, physical, archive, primary, inspect, toplevel);
    	admin._store();
    }
    

    static void updateComponentMapping(ConfigImpl config, String virtual, String physical,String archive,String primary, short inspect) throws SAXException, IOException, PageException {
    	ConfigWebAdmin admin = new ConfigWebAdmin(config, null);
    	admin._updateComponentMapping(virtual, physical, archive, primary, inspect);
    	admin._store();
    }
    

    static void updateCustomTagMapping(ConfigImpl config, String virtual, String physical,String archive,String primary, short inspect) throws SAXException, IOException, PageException {
    	ConfigWebAdmin admin = new ConfigWebAdmin(config, null);
    	admin._updateCustomTag(virtual, physical, archive, primary, inspect);
    	admin._store();
    }

    /**
     * insert or update a mapping on system
     * @param virtual
     * @param physical
     * @param archive
     * @param primary
     * @param trusted
     * @param toplevel 
     * @throws ExpressionException
     * @throws SecurityException
     */
    public void updateMapping(String virtual, String physical,String archive,String primary, short inspect, boolean toplevel) throws ExpressionException, SecurityException {
    	checkWriteAccess();
    	_updateMapping(virtual, physical, archive, primary, inspect, toplevel);
    }
    private void _updateMapping(String virtual, String physical,String archive,String primary, short inspect, boolean toplevel) throws ExpressionException, SecurityException {
    	boolean hasAccess=ConfigWebUtil.hasAccess(config,SecurityManager.TYPE_MAPPING);
        
        virtual=virtual.trim(); 
        if(physical==null) physical="";
        else physical=physical.trim();
        if(archive==null) archive="";
        else archive=archive.trim();
        primary=primary.trim();
        if(!hasAccess)
            throw new SecurityException("no access to update mappings");
        
        // check virtual
            if(virtual==null || virtual.length()==0)
                throw new ExpressionException("virtual path cannot be a empty value");
            virtual=virtual.replace('\\','/');
            
            if(!virtual.equals("/") && virtual.endsWith("/"))
    	            virtual=virtual.substring(0,virtual.length()-1);
            
            if(virtual.charAt(0)!='/')
                throw new ExpressionException("virtual path must start with [/]");
        boolean isArchive=primary.equalsIgnoreCase("archive");
        
        if((physical.length()+archive.length())==0)
            throw new ExpressionException("physical or archive must have a value");
        
        if(isArchive && archive.length()==0 ) isArchive=false;
        //print.ln("isArchive:"+isArchive);
        
        if(!isArchive && archive.length()>0 && physical.length()==0 ) isArchive=true;
        //print.ln("isArchive:"+isArchive);
        
        
        
        Element mappings=_getRootElement("mappings");
        // Update
        Element[] children = ConfigWebFactory.getChildren(mappings,"mapping");
      	for(int i=0;i<children.length;i++) {
      	    String v=children[i].getAttribute("virtual");
      	    if(v!=null) {
      	        if(!v.equals("/") && v.endsWith("/"))
      	            v=v.substring(0,v.length()-1);
              
	      	    if(v.equals(virtual)) {
		      		Element el=children[i];
		      		if(physical.length()>0) {
                        el.setAttribute("physical",physical);
                    }
                    else if(el.hasAttribute("physical")) {
                        el.removeAttribute("physical");
                    }
		      		if(archive.length()>0) {
                        el.setAttribute("archive",archive);
                    }
                    else if(el.hasAttribute("archive")) {
                        el.removeAttribute("archive");
                    }
		      		el.setAttribute("primary",isArchive?"archive":"physical");
		      		el.setAttribute("inspect-template",ConfigWebUtil.inspectTemplate(inspect, ""));
		      		el.removeAttribute("trusted");
		      		el.setAttribute("toplevel",Caster.toString(toplevel));
		      		return ;
	  			}
      	    }
      	}
      	
      	// Insert
      	Element el=doc.createElement("mapping");
      	mappings.appendChild(el);
      	el.setAttribute("virtual",virtual);
      	if(physical.length()>0)el.setAttribute("physical",physical);
  		if(archive.length()>0)el.setAttribute("archive",archive);
  		el.setAttribute("primary",isArchive?"archive":"physical");
  		el.setAttribute("inspect-template",ConfigWebUtil.inspectTemplate(inspect, ""));
  		el.setAttribute("toplevel",Caster.toString(toplevel));
  		
  		// set / to the end
  		children = ConfigWebFactory.getChildren(mappings,"mapping");
      	for(int i=0;i<children.length;i++) {
      	    String v=children[i].getAttribute("virtual");
      	    
  	        if(v!=null && v.equals("/")) {
	      		el=children[i];
	      		mappings.removeChild(el);
	      		mappings.appendChild(el);
	      		return ;
  			}

      	}
  		
    }
    
    public void updateRestMapping(String virtual, String physical,boolean _default) throws ExpressionException, SecurityException {
    	checkWriteAccess();
    	boolean hasAccess=true;// TODO ConfigWebUtil.hasAccess(config,SecurityManager.TYPE_REST);
        virtual=virtual.trim(); 
        physical=physical.trim();
        if(!hasAccess)
            throw new SecurityException("no access to update REST mapping");
        
        // check virtual
            if(virtual==null || virtual.length()==0)
                throw new ExpressionException("virtual path cannot be a empty value");
            virtual=virtual.replace('\\','/');
            if(virtual.equals("/"))
                throw new ExpressionException("virtual path cannot be /");
        
            
            if(virtual.endsWith("/"))
    	            virtual=virtual.substring(0,virtual.length()-1);
            
            if(virtual.charAt(0)!='/') virtual="/"+virtual;
        
        if((physical.length())==0)
        	throw new ExpressionException("physical path cannot be a empty value");
        
        Element rest=_getRootElement("rest");
        Element[] children = ConfigWebFactory.getChildren(rest,"mapping");
        
        // remove existing default
        if(_default) {
        	for(int i=0;i<children.length;i++) {
          	    if(Caster.toBooleanValue(children[i].getAttribute("default"),false))
          	    	children[i].setAttribute("default", "false");
          	}
        }
        
        // Update
        String v;
        Element el=null;
      	for(int i=0;i<children.length;i++) {
      	    v=children[i].getAttribute("virtual");
      	    if(v!=null && v.equals(virtual)) {
      	        el=children[i];
      	    }
      	}
      	
      	
      	// Insert
      	if(el==null) {
      		el=doc.createElement("mapping");
      		rest.appendChild(el);
      	}
      	
      	el.setAttribute("virtual",virtual);
      	el.setAttribute("physical",physical);
  		el.setAttribute("default",Caster.toString(_default));
  		  		
    }


    /**
     * delete a mapping on system
     * @param virtual
     * @throws ExpressionException
     * @throws SecurityException 
     */
    public void removeMapping(String virtual) throws ExpressionException, SecurityException {
    	checkWriteAccess();
    	// check parameters
        if(virtual==null || virtual.length()==0)
            throw new ExpressionException("virtual path cannot be a empty value");
        virtual=virtual.replace('\\','/');
        
        if(!virtual.equals("/") && virtual.endsWith("/"))
	            virtual=virtual.substring(0,virtual.length()-1);
        if(virtual.charAt(0)!='/')
            throw new ExpressionException("virtual path must start with [/]");
        
        
        Element mappings=_getRootElement("mappings");

        Element[] children = ConfigWebFactory.getChildren(mappings,"mapping");
      	for(int i=0;i<children.length;i++) {
      	    String v=children[i].getAttribute("virtual");
      	    if(v!=null) {
      	        if(!v.equals("/") && v.endsWith("/"))
      	            v=v.substring(0,v.length()-1);
	  	    	if(v!=null && v.equals(virtual)) {
		      		Element el=children[i];
		      		mappings.removeChild(el);
	  			}
      	    }
      	}
    }
    

    public void removeRestMapping(String virtual) throws ExpressionException, SecurityException {
    	checkWriteAccess();
    	// check parameters
        if(virtual==null || virtual.length()==0)
            throw new ExpressionException("virtual path cannot be a empty value");
        virtual=virtual.replace('\\','/');
        if(virtual.equals("/"))
            throw new ExpressionException("virtual path cannot be /");
        
        if(virtual.endsWith("/")) virtual=virtual.substring(0,virtual.length()-1);
        if(virtual.charAt(0)!='/') virtual="/"+virtual;
        
        
        
        Element mappings=_getRootElement("rest");

        Element[] children = ConfigWebFactory.getChildren(mappings,"mapping");
      	for(int i=0;i<children.length;i++) {
      	    String v=children[i].getAttribute("virtual");
      	    if(v!=null) {
      	        if(!v.equals("/") && v.endsWith("/"))
      	            v=v.substring(0,v.length()-1);
	  	    	if(v!=null && v.equals(virtual)) {
		      		Element el=children[i];
		      		mappings.removeChild(el);
	  			}
      	    }
      	}
    }

    /**
     * delete a customtagmapping on system
     * @param virtual
     * @throws SecurityException 
     */
    public void removeCustomTag(String virtual) throws SecurityException {
    	checkWriteAccess();
    	
        Element mappings=_getRootElement("custom-tag");
        Element[] children = ConfigWebFactory.getChildren(mappings,"mapping");
      	for(int i=0;i<children.length;i++) {
      	    if(virtual.equals(createVirtual(children[i])))mappings.removeChild(children[i]);
      	}
    }
    
    public void removeComponentMapping(String virtual) throws SecurityException {
    	checkWriteAccess();
    	
        Element mappings=_getRootElement("component");
        Element[] children = ConfigWebFactory.getChildren(mappings,"mapping");
        String v;
      	for(int i=0;i<children.length;i++) {
      		v=createVirtual(children[i]);
        	if(virtual.equals(v))mappings.removeChild(children[i]);
      	}
    }
    
    


    /**
     * insert or update a mapping for Custom Tag
     * @param virtual
     * @param physical
     * @param archive
     * @param primary
     * @param trusted
     * @throws ExpressionException
     * @throws SecurityException
     */
    public void updateCustomTag(String virtual,String physical,String archive,String primary, short inspect) throws ExpressionException, SecurityException {
    	checkWriteAccess();
    	_updateCustomTag(virtual, physical, archive, primary, inspect);
    }
    private void _updateCustomTag(String virtual,String physical,String archive,String primary, short inspect) throws ExpressionException, SecurityException {
    	boolean hasAccess=ConfigWebUtil.hasAccess(config,SecurityManager.TYPE_CUSTOM_TAG);
        if(!hasAccess)
            throw new SecurityException("no access to change custom tag settings");
        if(physical==null)physical="";
        if(archive==null)archive="";
        
        //virtual="/custom-tag";
        if(StringUtil.isEmpty(virtual))virtual=createVirtual(physical,archive);
        
        boolean isArchive=primary.equalsIgnoreCase("archive");
        if(isArchive && archive.length()==0 ) {
            throw new ExpressionException("archive must have a value when primary has value archive");
        }
        if(!isArchive && physical.length()==0 ) {
            throw new ExpressionException("physical must have a value when primary has value physical");
        }
        
        Element mappings=_getRootElement("custom-tag");
        
        // Update
        String v;
        Element[] children = ConfigWebFactory.getChildren(mappings,"mapping");
        for(int i=0;i<children.length;i++) {
        	Element el=children[i];
      		v=createVirtual(el);
        	if(v.equals(virtual)) {
        		el.setAttribute("virtual",v);
        		el.setAttribute("physical",physical);
	      		el.setAttribute("archive",archive);
	      		el.setAttribute("primary",primary.equalsIgnoreCase("archive")?"archive":"physical");
	      		el.setAttribute("inspect-template",ConfigWebUtil.inspectTemplate(inspect, ""));
	      		el.removeAttribute("trusted");
	      		return ;
  			}
      	}
      	
      	// Insert
      	Element el=doc.createElement("mapping");
      	mappings.appendChild(el);
      	if(physical.length()>0)el.setAttribute("physical",physical);
  		if(archive.length()>0)el.setAttribute("archive",archive);
  		el.setAttribute("primary",primary.equalsIgnoreCase("archive")?"archive":"physical");
  		el.setAttribute("inspect-template",ConfigWebUtil.inspectTemplate(inspect, ""));
  		el.setAttribute("virtual",virtual);
    }
    
    public void updateComponentMapping(String virtual,String physical,String archive,String primary, short inspect) throws ExpressionException, SecurityException {
    	checkWriteAccess();
    	_updateComponentMapping(virtual, physical, archive, primary, inspect);
    }	
    private void _updateComponentMapping(String virtual,String physical,String archive,String primary, short inspect) throws ExpressionException {
    	primary=primary.equalsIgnoreCase("archive")?"archive":"physical";
        if(physical==null)physical="";
        else physical=physical.trim();
        
    	if(archive==null)archive="";
        else archive=archive.trim();
        
        boolean isArchive=primary.equalsIgnoreCase("archive");
        if(isArchive && archive.length()==0 ) {
            throw new ExpressionException("archive must have a value when primary has value archive");
        }
        if(!isArchive && physical.length()==0 ) {
            throw new ExpressionException("physical must have a value when primary has value physical");
        }
        
        Element mappings=_getRootElement("component");
        Element[] children = ConfigWebFactory.getChildren(mappings,"mapping");
        Element el;
        
        /* ignore when exists
        for(int i=0;i<children.length;i++) {
      		el=children[i];
      	    if(el.getAttribute("physical").equals(physical) &&
      	    		el.getAttribute("archive").equals(archive) &&
      	    		el.getAttribute("primary").equals(primary) &&
      	    		el.getAttribute("trusted").equals(Caster.toString(trusted))){
      	    	return;
  			}
      	}*/
        
        
        // Update
        String v;
        for(int i=0;i<children.length;i++) {
        	el=children[i];
        	v=createVirtual(el); // if there is no virtual defintion (old records), we use the position
      		if(v.equals(virtual)) {
      			el.setAttribute("virtual",v); // set to make sure it exists for the future
      			el.setAttribute("physical",physical);
	      		el.setAttribute("archive",archive);
	      		el.setAttribute("primary",primary.equalsIgnoreCase("archive")?"archive":"physical");
	      		el.setAttribute("inspect-template",ConfigWebUtil.inspectTemplate(inspect, ""));
	      		el.removeAttribute("trusted");
	      		return ;
  			}
      	}
      	
      	// Insert
      	el=doc.createElement("mapping");
      	mappings.appendChild(el);
      	if(physical.length()>0)el.setAttribute("physical",physical);
  		if(archive.length()>0)el.setAttribute("archive",archive);
  		el.setAttribute("primary",primary.equalsIgnoreCase("archive")?"archive":"physical");
  		el.setAttribute("inspect-template",ConfigWebUtil.inspectTemplate(inspect, ""));
  		el.setAttribute("virtual",virtual);
    }

    


    public static String createVirtual(Element el) {
    	String str = el.getAttribute("virtual");
    	if(!StringUtil.isEmpty(str)) return str;
    	
    	return  createVirtual(el.getAttribute("physical"),el.getAttribute("archive"));
	}
    public static String createVirtual(String physical,String archive) {
    	return  "/"+MD5.getDigestAsString(physical+":"+archive,"");
	}


	/**
     * insert or update a Java CFX Tag
     * @param name
     * @param strClass
     * @throws PageException 
     */
    public void updateJavaCFX(String name,String strClass) throws PageException {
    	checkWriteAccess();
    	boolean hasAccess=ConfigWebUtil.hasAccess(config,SecurityManager.TYPE_CFX_SETTING);
        
        if(!hasAccess) throw new SecurityException("no access to change cfx settings");
        
        
        try {
        	Class clazz = ClassUtil.loadClass(config.getClassLoader(),strClass);
			if(!Reflector.isInstaneOf(clazz, CustomTag.class))
				throw new ExpressionException("class ["+strClass+"] must implement interface ["+CustomTag.class.getName()+"]");
           
        } 
        catch (ClassException e) {
        	
        	throw Caster.toPageException(e);
		}
        
        
        
        
        if(name==null || name.length()==0)
            throw new ExpressionException("class name can't be a empty value");
        
        renameOldstyleCFX();
        
        
        Element tags=_getRootElement("ext-tags");
        
        // Update
        Element[] children = ConfigWebFactory.getChildren(tags,"ext-tag");
      	for(int i=0;i<children.length;i++) {
      	    String n=children[i].getAttribute("name");
      	    
      	    if(n!=null && n.equalsIgnoreCase(name)) {
	      		Element el=children[i];
	      		if(!"java".equalsIgnoreCase(el.getAttribute("type"))) throw new ExpressionException("there is already a c++ cfx tag with this name");
      	    	el.setAttribute("class",strClass);
	      		el.setAttribute("type","java");
	      		return ;
  			}
      	    
      	}
      	
      	// Insert
      	Element el=doc.createElement("ext-tag");
      	tags.appendChild(el);
      	el.setAttribute("class",strClass);
      	el.setAttribute("name",name);
  		el.setAttribute("type","java");  		
    }
    
    public void updateCPPCFX(String name, String procedure, String strServerLibrary, boolean keepAlive) throws PageException {
    	checkWriteAccess();
    	boolean hasAccess=ConfigWebUtil.hasAccess(config,SecurityManager.TYPE_CFX_SETTING);
        
        if(!hasAccess) throw new SecurityException("no access to change cfx settings");
        
        // name
        if(StringUtil.isEmpty(name))
            throw new ExpressionException("name cannot be a empty value");
        
        // serverLibrary
        if(StringUtil.isEmpty(strServerLibrary)) throw new ExpressionException("serverLibrary cannot be a empty value");
        Resource serverLibrary = ResourceUtil.toResourceExisting(config, strServerLibrary);
        
        // procedure
        if(StringUtil.isEmpty(procedure)) throw new ExpressionException("procedure cannot be a empty value");
        
        renameOldstyleCFX();
        
        
        Element tags=_getRootElement("ext-tags");
        
        // Update
        Element[] children = ConfigWebFactory.getChildren(tags,"ext-tag");
      	for(int i=0;i<children.length;i++) {
      	    String n=children[i].getAttribute("name");
      	    
      	    if(n!=null && n.equalsIgnoreCase(name)) {
	      		Element el=children[i];
	      		if(!"cpp".equalsIgnoreCase(el.getAttribute("type"))) throw new ExpressionException("there is already a java cfx tag with this name");
      	    	el.setAttribute("server-library",serverLibrary.getAbsolutePath());
      	    	el.setAttribute("procedure",procedure);
      	    	el.setAttribute("keep-alive",Caster.toString(keepAlive));
      	    	el.setAttribute("type","cpp");
	      		return ;
  			}
      	    
      	}
      	
      	// Insert
      	Element el=doc.createElement("ext-tag");
      	tags.appendChild(el);
      	el.setAttribute("server-library",serverLibrary.getAbsolutePath());
    	el.setAttribute("procedure",procedure);
    	el.setAttribute("keep-alive",Caster.toString(keepAlive));
    	el.setAttribute("name",name);
  		el.setAttribute("type","cpp"); 
	}
    
    private void renameOldstyleCFX() {
    	
        Element tags=_getRootElement("ext-tags",false,true);
        if(tags!=null) return;
        tags=_getRootElement("cfx-tags",false,true);
        if(tags==null) return;
        
        
        
    	Element newTags = _getRootElement("ext-tags");
    	Element[] children = ConfigWebFactory.getChildren(tags,"cfx-tag");
    	String type;
      	// copy
    	for(int i=0;i<children.length;i++) {
      	    Element el=doc.createElement("ext-tag");
      	    newTags.appendChild(el);
      	    type=children[i].getAttribute("type");
      	    // java
      	    if(type.equalsIgnoreCase("java")){
      	    	el.setAttribute("class",children[i].getAttribute("class"));
      	    }
      	    // c++
      	    else {
      	    	el.setAttribute("server-library",children[i].getAttribute("server-library"));
      	    	el.setAttribute("procedure",children[i].getAttribute("procedure"));
      	    	el.setAttribute("keep-alive",children[i].getAttribute("keep-alive"));
      	    	
      	    }
          	el.setAttribute("name",children[i].getAttribute("name"));
      		el.setAttribute("type",children[i].getAttribute("type"));  
      	}
    	
    	// remove old
    	for(int i=0;i<children.length;i++) {
    		tags.removeChild(children[i]);
    	}
    	tags.getParentNode().removeChild(tags);
	}
    

    public static boolean fixLFI(Document doc) {
    	return "lucee-configuration".equals(doc.getDocumentElement().getNodeName());
    	
    }
    
    /**
     * make sure every context has a salt
     * */
    public static boolean fixSalt(Document doc) {
    	Element root=doc.getDocumentElement();
    	String salt=root.getAttribute("salt");
    	if(StringUtil.isEmpty(salt,true) || !Decision.isUUId(salt)) {
    		//create salt
    		root.setAttribute("salt",CreateUUID.invoke());
    		return true;
    	}
    	return false;
    }
    
    public static boolean fixPSQ(Document doc) {
    	
    	Element datasources=ConfigWebFactory.getChildByName(doc.getDocumentElement(),"data-sources",false,true);
        if(datasources!=null && datasources.hasAttribute("preserve-single-quote")){
        	Boolean b=Caster.toBoolean(datasources.getAttribute("preserve-single-quote"),null);
        	if(b!=null)datasources.setAttribute("psq",Caster.toString(!b.booleanValue()));
        	datasources.removeAttribute("preserve-single-quote");
        	return true;
        }
    	return false;
    }
    

    /**
     * the following code remove all logging defintions spread over the complete xml and adds them to the new "logging" tag
     * 
     * @param doc
     * @return
     */

    public static boolean fixLogging(ConfigServerImpl cs,ConfigImpl config,Document doc) {
    	
    	if(config.setVersion(doc)>=4.3D) return false;
    	
    	// datasource
    	Element src = ConfigWebFactory.getChildByName(doc.getDocumentElement(), "datasource");
    	fixLogging(cs,doc,src, "datasource",false,"{lucee-config}/logs/datasource.log");
    	
    	
    	setVersion(doc,Caster.toDoubleValue(Info.getVersionAsString().substring(0,3),4.3D));
    	
    	
    	if(config.setVersion(doc)>=4.2D) return true;
    	
    	
    	//setVersion(Caster.toDoubleValue(Info.getVersionAsString().substring(0,3),1.0D));
        
    	
    	// mapping
    	src = ConfigWebFactory.getChildByName(doc.getDocumentElement(), "mappings");
    	fixLogging(cs,doc,src, "mapping",false,"{lucee-config}/logs/mapping.log");
    	
    	// rest
    	src = ConfigWebFactory.getChildByName(doc.getDocumentElement(), "rest");
    	fixLogging(cs,doc,src, "rest",false,"{lucee-config}/logs/rest.log");
    	
    	// gateway
    	src = ConfigWebFactory.getChildByName(doc.getDocumentElement(), "gateways");
    	fixLogging(cs,doc,src, "gateway",false,"{lucee-config}/logs/gateway.log");
    	
    	// remote clients
    	src = ConfigWebFactory.getChildByName(doc.getDocumentElement(), "remote-clients");
    	fixLogging(cs,doc,src, "remoteclient",false,"{lucee-config}/logs/remoteclient.log");
    	
    	// orm
    	src = ConfigWebFactory.getChildByName(doc.getDocumentElement(), "orm");
    	fixLogging(cs,doc,src, "orm",false,"{lucee-config}/logs/orm.log");
    	
    	// mail
    	src = ConfigWebFactory.getChildByName(doc.getDocumentElement(), "mail");
    	fixLogging(cs,doc,src, "mail",false,"{lucee-config}/logs/mail.log");
    			
		// search
    	src = ConfigWebFactory.getChildByName(doc.getDocumentElement(), "search");
    	fixLogging(cs,doc,src, "search",false,"{lucee-config}/logs/search.log");
    	
    	// scheduler
    	src = ConfigWebFactory.getChildByName(doc.getDocumentElement(), "scheduler");
    	fixLogging(cs,doc,src, "scheduler",false,"{lucee-config}/logs/scheduler.log");
    	
		// scope
    	src = ConfigWebFactory.getChildByName(doc.getDocumentElement(), "scope");
    	fixLogging(cs,doc,src, "scope",false,"{lucee-config}/logs/scope.log");
    	
    	// application
    	Element app = src = ConfigWebFactory.getChildByName(doc.getDocumentElement(), "application");
    	fixLogging(cs,doc,src, "application","application-log","application-log-level",false,"{lucee-config}/logs/application.log");
    	
    	// exception
    	fixLogging(cs,doc,app, "exception","exception-log","exception-log-level",false,"{lucee-config}/logs/exception.log");
    	
    	// trace
    	fixLogging(cs,doc,app, "trace","trace-log","trace-log-level",false,"{lucee-config}/logs/trace.log");
    	
    	// thread
    	fixLogging(cs,doc,app, "thread","thread-log","thread-log-level",false,"{lucee-config}/logs/thread.log");
    	
    	// deploy
    	fixLogging(cs,doc,app, "deploy","deploy-log","deploy-log-level",false,"{lucee-config}/logs/deploy.log");
    	
    	// requesttimeout
    	fixLogging(cs,doc,app, "requesttimeout","requesttimeout-log","requesttimeout-log-level",false,"{lucee-config}/logs/requesttimeout.log");
    	
    	setVersion(doc,Caster.toDoubleValue(Info.getVersionAsString().substring(0,3),4.3D));
    	
    	
    	return true;
    }

    private static boolean fixLogging(ConfigServerImpl cs, Document doc,Element src, String name,boolean deleteSourceAttributes, String defaultValue) {
    	return fixLogging(cs, doc, src, name, "log", "log-level", deleteSourceAttributes, defaultValue);
    }
    private static boolean fixLogging(ConfigServerImpl cs, Document doc,Element src, String name,String logName, String levelName,boolean deleteSourceAttributes, String defaultValue) {
    	
    	
    	String path,level;
    	// Mapping logging
    	
    	path = src.getAttribute(logName);
    	level = src.getAttribute(levelName);
    	
    	if(StringUtil.isEmpty(path) && !StringUtil.isEmpty(defaultValue) && (cs==null || cs.getLog(name)==null)) {
    		// ignore defaultValue, when there is a setting in server context
    		path=defaultValue;
    	}
    	if(!StringUtil.isEmpty(path)) {
	    	if(deleteSourceAttributes)src.removeAttribute(logName);
	    	if(deleteSourceAttributes)src.removeAttribute(levelName);
    		
    		Element logging = ConfigWebFactory.getChildByName(doc.getDocumentElement(), "logging");
    		
    		// first of all we have to make sure this is not already existing, if it does we ignore the old settings
    		Element[] children = XMLUtil.getChildElementsAsArray(logging);
    		for(int i=0;i<children.length;i++){
    			if(children[i].getTagName().equals("logger") && name.equalsIgnoreCase(children[i].getAttribute("name"))) {
    				return false;
    			}
    		}
	    	
    		SystemOut.printDate("move "+name+" logging");
	    	Element logger = doc.createElement("logger");
	    	logger.setAttribute("name", name);
	    	if("console".equalsIgnoreCase(path)) {
		    	logger.setAttribute("appender", "console");
	    		logger.setAttribute("layout", "pattern");
	    	}
	    	else {
		    	logger.setAttribute("appender", "resource");
		    	logger.setAttribute("appender-arguments", "path:"+path);
	    		logger.setAttribute("layout", "classic");
    		}
	    	
	    	if(!StringUtil.isEmpty(level,true))logger.setAttribute("level", level.trim());

	    	logging.appendChild(logger);
	    	
	    	return true;
    	}
    	return false;
    }


    public static boolean fixS3(Document doc) {
    	Element resources=ConfigWebFactory.getChildByName(doc.getDocumentElement(),"resources",false,true);
        
        Element[] providers = ConfigWebFactory.getChildren(resources,"resource-provider");
        
        // replace extension class with core class
        for(int i=0;i<providers.length;i++) {
        	if("s3".equalsIgnoreCase(providers[i].getAttribute("scheme"))) {
        		if("lucee.extension.io.resource.type.s3.S3ResourceProvider".equalsIgnoreCase(providers[i].getAttribute("class"))){
        			providers[i].setAttribute("class", S3ResourceProvider.class.getName());
        			return true;
        		}
        		return false;
        	}
        }
        
        
        // FUTURE remove this part in upcoming versions
        // add s3 when not
        Element el=doc.createElement("resource-provider");
        el.setAttribute("scheme", "s3");
        el.setAttribute("class", S3ResourceProvider.class.getName());
        el.setAttribute("arguments", "lock-timeout:10000;");
        resources.appendChild(el);
        
        return true;
	}

    
    
  
    public void verifyCFX(String name) throws PageException {
    	CFXTagPool pool=config.getCFXTagPool();
		CustomTag ct=null;
		try {
			ct = pool.getCustomTag(name);
		} 
        catch (CFXTagException e) {
			throw Caster.toPageException(e);
		}
        finally {
        	if(ct!=null)pool.releaseCustomTag(ct);
        }
		
	}
    


	public void verifyJavaCFX(String name,String strClass) throws PageException {
    	try {
    		Class clazz = ClassUtil.loadClass(config.getClassLoader(),strClass);
			if(!Reflector.isInstaneOf(clazz, CustomTag.class))
				throw new ExpressionException("class ["+strClass+"] must implement interface ["+CustomTag.class.getName()+"]");
        } 
        catch (ClassException e) {
        	throw Caster.toPageException(e);
		}
        
        if(StringUtil.startsWithIgnoreCase(name,"cfx_"))name=name.substring(4);
        if(StringUtil.isEmpty(name))
            throw new ExpressionException("class name can't be a empty value");
    }
    

    /**
     * remove a CFX Tag
     * @param name
     * @throws ExpressionException
     * @throws SecurityException 
     */
    public void removeCFX(String name) throws ExpressionException, SecurityException {
    	checkWriteAccess();
    	// check parameters
        if(name==null || name.length()==0)
            throw new ExpressionException("name for CFX Tag can be a empty value");
        
        renameOldstyleCFX();
        
        Element mappings=_getRootElement("ext-tags");

        Element[] children = ConfigWebFactory.getChildren(mappings,"ext-tag");
      	for(int i=0;i<children.length;i++) {
      	    String n=children[i].getAttribute("name"); 
  	    	if(n!=null && n.equalsIgnoreCase(name)) {
	      		mappings.removeChild(children[i]);
  			}
  	    }
    }

    /**
     * update or insert new database connection
     * @param name
     * @param clazzName
     * @param dsn
     * @param username
     * @param password
     * @param host 
     * @param database 
     * @param port 
     * @param connectionLimit 
     * @param connectionTimeout 
     * @param blob 
     * @param clob 
     * @param allow 
     * @param storage 
     * @param custom 
     * @throws ExpressionException
     * @throws SecurityException
     */
    public void updateDataSource(String name, String newName, String clazzName, String dsn, String username, String password,
            String host, String database, int port, int connectionLimit, int connectionTimeout, long metaCacheTimeout,
            boolean blob, boolean clob, int allow, boolean validate, boolean storage, String timezone, Struct custom, String dbdriver) throws ExpressionException, SecurityException {

    	checkWriteAccess();
    	SecurityManager sm = config.getSecurityManager();
    	short access = sm.getAccess(SecurityManager.TYPE_DATASOURCE);
    	boolean hasAccess=true;
    	boolean hasInsertAccess=true;
    	int maxLength=0;
    	
    	if(access==SecurityManager.VALUE_YES) hasAccess=true;
    	else if(access==SecurityManager.VALUE_NO) hasAccess=false;
    	else if(access>=SecurityManager.VALUE_1 && access<=SecurityManager.VALUE_10){
    		int existingLength=getDatasourceLength(config);
    		maxLength=access-SecurityManager.NUMBER_OFFSET;
    		hasInsertAccess=maxLength>existingLength;
        	//print.ln("maxLength:"+maxLength);
        	//print.ln("existingLength:"+existingLength);
    	}
    	//print.ln("hasAccess:"+hasAccess);
    	//print.ln("hasInsertAccess:"+hasInsertAccess);
        
        //boolean hasAccess=ConfigWebUtil.hasAccess(config,SecurityManager.TYPE_DATASOURCE);
        if(!hasAccess)
            throw new SecurityException("no access to update datsource connections");
        
        // check parameters
        if(name==null || name.length()==0)
            throw new ExpressionException("name can't be a empty value");
        
        try {
			ClassUtil.loadInstance(clazzName);
		}
        catch (ClassException e) {
            throw new ExpressionException(e.getMessage());
		}
        
        Element datasources=_getRootElement("data-sources");
        
        // Update
        Element[] children = ConfigWebFactory.getChildren(datasources,"data-source");
      	for(int i=0;i<children.length;i++) {
      	    String n=children[i].getAttribute("name");
      	    
      	    if(n.equalsIgnoreCase(name)) {
	      		Element el=children[i];
	      		if(password.equalsIgnoreCase("****************"))
	            	password=el.getAttribute("password");
	            
	      		if(!StringUtil.isEmpty(newName) && !newName.equals(name))
	      			el.setAttribute("name",newName);
	      		el.setAttribute("class",clazzName);
	      		el.setAttribute("dsn",dsn);
	      		el.setAttribute("username",username);
	      		el.setAttribute("password",ConfigWebFactory.encrypt(password));

                el.setAttribute("host",host);
                if(!StringUtil.isEmpty(timezone))el.setAttribute("timezone",timezone);
                else if(el.hasAttribute("timezone")) el.removeAttribute("timezone");
                el.setAttribute("database",database);
                el.setAttribute("port",Caster.toString(port));
                el.setAttribute("connectionLimit",Caster.toString(connectionLimit));
                el.setAttribute("connectionTimeout",Caster.toString(connectionTimeout));
                el.setAttribute("metaCacheTimeout",Caster.toString(metaCacheTimeout));
                el.setAttribute("blob",Caster.toString(blob));
                el.setAttribute("clob",Caster.toString(clob));
                el.setAttribute("allow",Caster.toString(allow));
                el.setAttribute("validate",Caster.toString(validate));
                el.setAttribute("storage",Caster.toString(storage));
                el.setAttribute("custom",toStringURLStyle(custom));

	            if (!StringUtil.isEmpty( dbdriver ))
		            el.setAttribute("dbdriver", Caster.toString(dbdriver));

	      		return;
  			}
      	}
      	
      	if(!hasInsertAccess)
            throw new SecurityException("no access to add datasource connections, the maximum count of ["+maxLength+"] datasources is reached");
      	
      	// Insert
      	Element el=doc.createElement("data-source");
      	datasources.appendChild(el);
      	if(!StringUtil.isEmpty(newName))
      		el.setAttribute("name",newName);
      	else 
      		el.setAttribute("name",name);
  		el.setAttribute("class",clazzName);
  		el.setAttribute("dsn",dsn);
  		if(username.length()>0)el.setAttribute("username",username);
  		if(password.length()>0)el.setAttribute("password",ConfigWebFactory.encrypt(password));
        
        el.setAttribute("host",host);
        if(!StringUtil.isEmpty(timezone))el.setAttribute("timezone",timezone);
        el.setAttribute("database",database);
        if(port>-1)el.setAttribute("port",Caster.toString(port));
        if(connectionLimit>-1)el.setAttribute("connectionLimit",Caster.toString(connectionLimit));
        if(connectionTimeout>-1)el.setAttribute("connectionTimeout",Caster.toString(connectionTimeout));
        if(metaCacheTimeout>-1)el.setAttribute("metaCacheTimeout",Caster.toString(metaCacheTimeout));
        
        el.setAttribute("blob",Caster.toString(blob));
        el.setAttribute("clob",Caster.toString(clob));
        el.setAttribute("validate",Caster.toString(validate));
        el.setAttribute("storage",Caster.toString(storage));
        if(allow>-1)el.setAttribute("allow",Caster.toString(allow));
        el.setAttribute("custom",toStringURLStyle(custom));

	    if (!StringUtil.isEmpty( dbdriver ))
		    el.setAttribute("dbdriver", Caster.toString(dbdriver));

        /*
  		    String host,String database,int port,String connectionLimit, String connectionTimeout,
            boolean blob,boolean clob,int allow,Struct custom
        );
        */
    }
    

	public void updateGatewayEntry(String id,String className, String cfcPath, String listenerCfcPath,int startupMode,Struct custom, boolean readOnly) throws PageException {
		
		checkWriteAccess();
    	boolean hasAccess=ConfigWebUtil.hasAccess(config,SecurityManagerImpl.TYPE_GATEWAY);
        
    	if(!hasAccess)
            throw new SecurityException("no access to update gateway entry");
        
    	
        // check parameters
        id=id.trim();
    	if(StringUtil.isEmpty(id))
            throw new ExpressionException("id can't be a empty value");
    	
    	if(StringUtil.isEmpty(className) && StringUtil.isEmpty(cfcPath))
    		throw new ExpressionException("you must define className or cfcPath");
    	
        try {
        	if(!StringUtil.isEmpty(className)){
	        	ClassUtil.loadClass(className);
        	}
		}
        catch (ClassException e) {
            throw new ExpressionException(e.getMessage());
		}
        
        Element parent=_getRootElement("gateways");
        
        // Update
        Element[] children = ConfigWebFactory.getChildren(parent,"gateway");
      	for(int i=0;i<children.length;i++) {
      	    String n=children[i].getAttribute("id");
      	    Element el=children[i];
      	    if(n.equalsIgnoreCase(id)) {
      	    	el.setAttribute("class",className);
      	    	el.setAttribute("cfc-path",cfcPath);
      	    	el.setAttribute("listener-cfc-path",listenerCfcPath);
      	    	el.setAttribute("startup-mode",GatewayEntryImpl.toStartup(startupMode, "automatic"));
      	    	el.setAttribute("custom",toStringURLStyle(custom));
	      		el.setAttribute("read-only",Caster.toString(readOnly));
	      		return;
  			}
      	  
      	}
      	// Insert
      	Element el=doc.createElement("gateway");
      	parent.appendChild(el);
      	el.setAttribute("id",id);
      	el.setAttribute("cfc-path",cfcPath);
      	el.setAttribute("listener-cfc-path",listenerCfcPath);
	    el.setAttribute("startup-mode",GatewayEntryImpl.toStartup(startupMode, "automatic"));
	    el.setAttribute("class",className);
  		el.setAttribute("custom",toStringURLStyle(custom));
  		el.setAttribute("read-only",Caster.toString(readOnly));
        
    }

	public void updateCacheConnection(String name, String classname,int _default, Struct custom,boolean readOnly,boolean storage) throws PageException {
    	
		checkWriteAccess();
    	boolean hasAccess=ConfigWebUtil.hasAccess(config,SecurityManagerImpl.TYPE_CACHE);
		if(!hasAccess)
            throw new SecurityException("no access to update cache connection");
        
    	
        // check parameters
        name=name.trim();
    	if(StringUtil.isEmpty(name))
            throw new ExpressionException("name can't be a empty value");
    	//else if(name.equals("template") || name.equals("object"))
    		//throw new ExpressionException("name ["+name+"] is not allowed for a cache connection, the following names are reserved words [object,template]");	
        
        try {
        	Class clazz;
        	if(classname!=null && classname.endsWith(".EHCacheLite")) clazz=EHCache.class;
        	else clazz = ClassUtil.loadClass(config.getClassLoader(),classname);
			if(!Reflector.isInstaneOf(clazz, Cache.class))
				throw new ExpressionException("class ["+clazz.getName()+"] is not of type ["+Cache.class.getName()+"]");
		}
        catch (ClassException e) {
            throw new ExpressionException(e.getMessage());
		}
        
        Element parent=_getRootElement("cache");

        if(name.equalsIgnoreCase(parent.getAttribute("default-template")))
    		parent.removeAttribute("default-template");
        if(name.equalsIgnoreCase(parent.getAttribute("default-object")))
    		parent.removeAttribute("default-object");
        if(name.equalsIgnoreCase(parent.getAttribute("default-query")))
    		parent.removeAttribute("default-query");
        if(name.equalsIgnoreCase(parent.getAttribute("default-resource")))
    		parent.removeAttribute("default-resource");
        if(name.equalsIgnoreCase(parent.getAttribute("default-function")))
    		parent.removeAttribute("default-function");
        if(name.equalsIgnoreCase(parent.getAttribute("default-include")))
    		parent.removeAttribute("default-include");
        
        
        if(_default==ConfigImpl.CACHE_DEFAULT_OBJECT){
        	parent.setAttribute("default-object",name);
        }
        else if(_default==ConfigImpl.CACHE_DEFAULT_TEMPLATE){
        	parent.setAttribute("default-template",name);
        }
        else if(_default==ConfigImpl.CACHE_DEFAULT_QUERY){
        	parent.setAttribute("default-query",name);
        }
        else if(_default==ConfigImpl.CACHE_DEFAULT_RESOURCE){
        	parent.setAttribute("default-resource",name);
        }
        else if(_default==ConfigImpl.CACHE_DEFAULT_FUNCTION){
        	parent.setAttribute("default-function",name);
        }
        else if(_default==ConfigImpl.CACHE_DEFAULT_INCLUDE){
        	parent.setAttribute("default-include",name);
        }
        
        // Update
        //boolean isUpdate=false;
        Element[] children = ConfigWebFactory.getChildren(parent,"connection");
      	for(int i=0;i<children.length;i++) {
      	    String n=children[i].getAttribute("name");
      	    Element el=children[i];
      	    if(n.equalsIgnoreCase(name)) {
      	    	el.setAttribute("class",classname);
	      		//el.setAttribute("default",Caster.toString(_default));
	      		el.setAttribute("custom",toStringURLStyle(custom));
	      		el.setAttribute("read-only",Caster.toString(readOnly));
	      		el.setAttribute("storage",Caster.toString(storage));
	      		return;
  			}
      	  
      	}
      	
      	// Insert
      	Element el=doc.createElement("connection");
      	parent.appendChild(el);
      	el.setAttribute("name",name);
  		el.setAttribute("class",classname);
  		//el.setAttribute("default",Caster.toString(_default));
  		el.setAttribute("custom",toStringURLStyle(custom));
  		el.setAttribute("read-only",Caster.toString(readOnly));
  		el.setAttribute("storage",Caster.toString(storage));
        
    }
	
	public void removeCacheDefaultConnection(int type) throws PageException {
    	checkWriteAccess();
    	
    	boolean hasAccess=ConfigWebUtil.hasAccess(config,SecurityManagerImpl.TYPE_CACHE);
        if(!hasAccess)
            throw new SecurityException("no access to update cache connections");
        
        Element parent=_getRootElement("cache");
        if(type==ConfigImpl.CACHE_DEFAULT_OBJECT){
        	parent.removeAttribute("default-object");
        }
        else if(type==ConfigImpl.CACHE_DEFAULT_TEMPLATE){
        	parent.removeAttribute("default-template");
        }
        else if(type==ConfigImpl.CACHE_DEFAULT_QUERY){
        	parent.removeAttribute("default-query");
        }
        else if(type==ConfigImpl.CACHE_DEFAULT_RESOURCE){
        	parent.removeAttribute("default-resource");
        }
        else if(type==ConfigImpl.CACHE_DEFAULT_FUNCTION){
        	parent.removeAttribute("default-function");
        }
        else if(type==ConfigImpl.CACHE_DEFAULT_INCLUDE){
        	parent.removeAttribute("default-include");
        }
    }
	
	public void updateCacheDefaultConnection(int type,String name) throws PageException {
    	checkWriteAccess();
    	boolean hasAccess=ConfigWebUtil.hasAccess(config,SecurityManagerImpl.TYPE_CACHE);
        
    	if(!hasAccess)
            throw new SecurityException("no access to update cache default connections");
        
        Element parent=_getRootElement("cache");
        if(type==ConfigImpl.CACHE_DEFAULT_OBJECT){
        	parent.setAttribute("default-object", name);
        }
        else if(type==ConfigImpl.CACHE_DEFAULT_TEMPLATE){
        	parent.setAttribute("default-template", name);
        }
        else if(type==ConfigImpl.CACHE_DEFAULT_QUERY){
        	parent.setAttribute("default-query", name);
        }
        else if(type==ConfigImpl.CACHE_DEFAULT_RESOURCE){
        	parent.setAttribute("default-resource", name);
        }
        else if(type==ConfigImpl.CACHE_DEFAULT_FUNCTION){
        	parent.setAttribute("default-function", name);
        }
        else if(type==ConfigImpl.CACHE_DEFAULT_INCLUDE){
        	parent.setAttribute("default-include", name);
        }
    }
	
    public void removeResourceProvider(Class clazz) throws PageException {
    	checkWriteAccess();
    	SecurityManager sm = config.getSecurityManager();
    	short access = sm.getAccess(SecurityManager.TYPE_FILE);
    	boolean hasAccess=access==SecurityManager.VALUE_YES;
    	
    	String className=clazz.getName();
    	
    	if(!hasAccess)
            throw new SecurityException("no access to remove resources");
        
        Element parent=_getRootElement("resources");
        
        // remove
        Element[] children = ConfigWebFactory.getChildren(parent,"resource-provider");
      	for(int i=0;i<children.length;i++) {
      	    String cn=children[i].getAttribute("class");
      	    if(cn.equalsIgnoreCase(className)) {
      	    	parent.removeChild(children[i]);                
	      		break;
  			}
      	}
	}	
    
    public void updateResourceProvider(String scheme, Class clazz,Struct arguments) throws PageException {
    	updateResourceProvider(scheme, clazz, toStringCSSStyle(arguments));
    }

	public void updateResourceProvider(String scheme, Class clazz,String arguments) throws PageException {
    	checkWriteAccess();
    	SecurityManager sm = config.getSecurityManager();
    	short access = sm.getAccess(SecurityManager.TYPE_FILE);
    	boolean hasAccess=access==SecurityManager.VALUE_YES;
    	
    	String className=clazz.getName();
    	
    	if(!hasAccess)
            throw new SecurityException("no access to update resources");
        
        // check parameters
    	if(StringUtil.isEmpty(scheme))throw new ExpressionException("scheme can't be a empty value");
    	
        Element parent=_getRootElement("resources");
        
        // Update
        Element[] children = ConfigWebFactory.getChildren(parent,"resource-provider");
      	for(int i=0;i<children.length;i++) {
      	    String cn=children[i].getAttribute("class");
      	    if(cn.equalsIgnoreCase(className)) {
	      		Element el=children[i];
	      		el.setAttribute("scheme",scheme);
	      		el.setAttribute("arguments",arguments);                
	      		return ;
  			}
      	}
      	
      	// Insert
      	Element el=doc.createElement("resource-provider");
      	parent.appendChild(el);
  		el.setAttribute("scheme",scheme);
  		el.setAttribute("arguments",arguments);  
  		el.setAttribute("class",className);
	}	
	
	public void updateDefaultResourceProvider(Class clazz, String arguments) throws PageException {
    	checkWriteAccess();
    	SecurityManager sm = config.getSecurityManager();
    	short access = sm.getAccess(SecurityManager.TYPE_FILE);
    	boolean hasAccess=access==SecurityManager.VALUE_YES;
    	
    	String className=clazz.getName();
    	
    	if(!hasAccess)
            throw new SecurityException("no access to update resources");
        
        Element parent=_getRootElement("resources");
        
        // Update
        Element[] children = ConfigWebFactory.getChildren(parent,"default-resource-provider");
      	for(int i=0;i<children.length;i++) {
      	    Element el=children[i];
      		el.setAttribute("arguments",arguments);                
      		return;
      	}
      	
      	// Insert
      	Element el=doc.createElement("default-resource-provider");
      	parent.appendChild(el);
  		el.setAttribute("arguments",arguments);  
  		el.setAttribute("class",className);
	}

    private int getDatasourceLength(ConfigImpl config) {
    	Map ds = config.getDataSourcesAsMap();
    	Iterator it = ds.keySet().iterator();
    	int len=0;
    	
    	while(it.hasNext()) {
    		if(!((DataSource)ds.get(it.next())).isReadOnly())len++;
    	}
		return len;
	}


	private static String toStringURLStyle(Struct sct) {
        Iterator<Entry<Key, Object>> it = sct.entryIterator();
		Entry<Key, Object> e;
		StringBuilder rtn=new StringBuilder();
        while(it.hasNext()) {
            e = it.next();
            if(rtn.length()>0)rtn.append('&');
            rtn.append(URLEncoder.encode(e.getKey().getString()));
            rtn.append('=');
            rtn.append(URLEncoder.encode(Caster.toString(e.getValue(),"")));
        }
        return rtn.toString();
    }

	private static String toStringCSSStyle(Struct sct) {
        //Collection.Key[] keys = sct.keys();
		StringBuilder rtn=new StringBuilder();
        Iterator<Entry<Key, Object>> it = sct.entryIterator();
		Entry<Key, Object> e;
        
		while(it.hasNext()) {
			e = it.next();
            if(rtn.length()>0)rtn.append(';');
            rtn.append(encode(e.getKey().getString()));
            rtn.append(':');
            rtn.append(encode(Caster.toString(e.getValue(),"")));
        }
        return rtn.toString();
    }

    private static String encode(String str) {
		try {
			return URLEncodedFormat.invoke(str, "UTF-8",false);
		} catch (PageException e) {
			return URLEncoder.encode(str);
		}
	}


	public Query getResourceProviders() throws PageException {
    	checkReadAccess();
        // check parameters
        Element parent=_getRootElement("resources");
        Element[] elProviders = ConfigWebFactory.getChildren(parent,"resource-provider");
        Element[] elDefaultProviders = ConfigWebFactory.getChildren(parent,"default-resource-provider");
        ResourceProvider[] providers = config.getResourceProviders();
        ResourceProvider defaultProvider = config.getDefaultResourceProvider();
		
        Query qry=new QueryImpl(new String[]{"support","scheme","caseSensitive","default","class","arguments"},elProviders.length+elDefaultProviders.length,"resourceproviders");
        int row=1;
        for(int i=0;i<elDefaultProviders.length;i++) {
      		getResourceProviders(new ResourceProvider[]{defaultProvider},qry,elDefaultProviders[i],row++,Boolean.TRUE);
  	    }
        for(int i=0;i<elProviders.length;i++) {
      		getResourceProviders(providers,qry,elProviders[i],row++,Boolean.FALSE);
  	    }
      	return qry;
    }
    
    private void getResourceProviders(ResourceProvider[] providers,Query qry,Element p, int row,Boolean def) throws PageException {
    	Array support=new ArrayImpl();
  	    String clazz=p.getAttribute("class");
  		qry.setAt("scheme",row,p.getAttribute("scheme"));
  		qry.setAt("arguments",row,p.getAttribute("arguments"));
  		qry.setAt("class",row,clazz);
  		for(int i=0;i<providers.length;i++) {
  			if(providers[i].getClass().getName().equals(clazz)){
  				if(providers[i].isAttributesSupported())support.append("attributes");
  	            if(providers[i].isModeSupported())support.append("mode");
  	            qry.setAt("support",row,ListUtil.arrayToList(support, ","));
  	            qry.setAt("scheme",row,providers[i].getScheme());
  	            qry.setAt("caseSensitive",row,Caster.toBoolean(providers[i].isCaseSensitive()));
  	            qry.setAt("default",row,def);
  				break;
  			}
  		}
	}


	/**
     * remove a DataSource Connection
     * @param name
     * @throws ExpressionException
     * @throws SecurityException 
     */
    public void removeDataSource(String name) throws ExpressionException, SecurityException {
    	checkWriteAccess();
        // check parameters
        if(name==null || name.length()==0)
            throw new ExpressionException("name for Datasource Connection can be a empty value");
        

        Element datasources=_getRootElement("data-sources");

        Element[] children = ConfigWebFactory.getChildren(datasources,"data-source");
      	for(int i=0;i<children.length;i++) {
      	    String n=children[i].getAttribute("name"); 
  	    	if(n!=null && n.equalsIgnoreCase(name)) {
  	    	  datasources.removeChild(children[i]);
  			}
  	    }
    }

	public void removeCacheConnection(String name) throws ExpressionException, SecurityException {
		checkWriteAccess();
		
		boolean hasAccess=ConfigWebUtil.hasAccess(config,SecurityManagerImpl.TYPE_CACHE);
		if(!hasAccess)
            throw new SecurityException("no access to remove cache connection");
        
		
        // check parameters
        if(StringUtil.isEmpty(name))
            throw new ExpressionException("name for Cache Connection can be a empty value");
        
        Element parent=_getRootElement("cache");
        
        // remove default flag
        if(name.equalsIgnoreCase(parent.getAttribute("default-object")))
        	parent.removeAttribute("default-object");
        if(name.equalsIgnoreCase(parent.getAttribute("default-template")))
        	parent.removeAttribute("default-template");
        if(name.equalsIgnoreCase(parent.getAttribute("default-query")))
        	parent.removeAttribute("default-query");
        if(name.equalsIgnoreCase(parent.getAttribute("default-resource")))
        	parent.removeAttribute("default-resource");
        
        // remove element
        Element[] children = ConfigWebFactory.getChildren(parent,"connection");
      	for(int i=0;i<children.length;i++) {
      	    String n=children[i].getAttribute("name"); 
  	    	if(n!=null && n.equalsIgnoreCase(name)) {
  	    		Map<String, CacheConnection> conns = config.getCacheConnections();
  	    		CacheConnection cc= conns.get(n.toLowerCase());
  	    		if(cc!=null)Util.removeEL(config instanceof ConfigWeb?(ConfigWeb)config:null,cc);
  	    	  parent.removeChild(children[i]);
  			}
  	    }
      	
	}
	

	public void removeCacheGatewayEntry(String name) throws PageException {
		checkWriteAccess();
        
		boolean hasAccess=ConfigWebUtil.hasAccess(config,SecurityManagerImpl.TYPE_GATEWAY);
        if(!hasAccess)
            throw new SecurityException("no access to remove gateway entry");
        
        if(StringUtil.isEmpty(name))
            throw new ExpressionException("name for Gateway Id can be a empty value");
        
        Element parent=_getRootElement("gateways");
        
        // remove element
        Element[] children = ConfigWebFactory.getChildren(parent,"gateway");
      	for(int i=0;i<children.length;i++) {
      	    String n=children[i].getAttribute("id"); 
  	    	if(n!=null && n.equalsIgnoreCase(name)) {
  	    		Map conns = ((ConfigWebImpl)config).getGatewayEngine().getEntries();
  	    		GatewayEntry ge=(GatewayEntry) conns.get(n);
  	    		if(ge!=null){
  	    			((ConfigWebImpl)config).getGatewayEngine().remove(ge);
  	    		}
  	    		parent.removeChild(children[i]);
  			}
  	    }
	}

	
	
    public void removeRemoteClient(String url) throws ExpressionException, SecurityException {
    	checkWriteAccess();
    	
    	// SNSN
    	
    	
    	boolean hasAccess=ConfigWebUtil.hasAccess(config,SecurityManagerImpl.TYPE_REMOTE);
        if(!hasAccess)
            throw new SecurityException("no access to remove remote client settings");
        
    	
    	
    	// check parameters
        if(StringUtil.isEmpty(url))
            throw new ExpressionException("url for Remote Client can be a empty value");
        

        Element clients=_getRootElement("remote-clients");

        Element[] children = ConfigWebFactory.getChildren(clients,"remote-client");
      	for(int i=0;i<children.length;i++) {
      	    String n=children[i].getAttribute("url"); 
  	    	if(n!=null && n.equalsIgnoreCase(url)) {
  	    	  clients.removeChild(children[i]);
  			}
  	    }
    }
    
    /**
     * 	update PSQ State
     * @param psq Preserver Single Quote
     * @throws SecurityException
     */
    public void updatePSQ(Boolean psq) throws SecurityException {
    	checkWriteAccess();
        boolean hasAccess=ConfigWebUtil.hasAccess(config,SecurityManager.TYPE_DATASOURCE);
        
        if(!hasAccess) throw new SecurityException("no access to update datsource connections");
        
        Element datasources=_getRootElement("data-sources");
        datasources.setAttribute("psq",Caster.toString(psq,""));
        if(datasources.hasAttribute("preserve-single-quote"))
        	datasources.removeAttribute("preserve-single-quote");
    }


	public void updateInspectTemplate(String str) throws SecurityException {
		checkWriteAccess();
        boolean hasAccess=ConfigWebUtil.hasAccess(config,SecurityManager.TYPE_SETTING);
        
        if(!hasAccess) throw new SecurityException("no access to update");
        
        Element datasources=_getRootElement("java");
        datasources.setAttribute("inspect-template",str);

	}
	

	public void updateTypeChecking(Boolean typeChecking) throws SecurityException {
		checkWriteAccess();
        boolean hasAccess=ConfigWebUtil.hasAccess(config,SecurityManager.TYPE_SETTING);
        
        if(!hasAccess) throw new SecurityException("no access to update");
        
        Element datasources=_getRootElement("application");
        if(typeChecking==null)datasources.removeAttribute("type-checking");
        else datasources.setAttribute("type-checking",Caster.toString(typeChecking.booleanValue()));

	}
	
	
    
    
    /**
     * sets the scope cascading type
     * @param type (ServletConfigImpl.SCOPE_XYZ)
     * @throws SecurityException
     */ 
    public void updateScopeCascadingType(String type) throws SecurityException {
    	checkWriteAccess();
        boolean hasAccess=ConfigWebUtil.hasAccess(config,SecurityManager.TYPE_SETTING);
        
        if(!hasAccess) throw new SecurityException("no access to update scope setting");
        
        
        Element scope=_getRootElement("scope");
        if(type.equalsIgnoreCase("strict"))        scope.setAttribute("cascading","strict");
        else if(type.equalsIgnoreCase("small"))    scope.setAttribute("cascading","small");
        else if(type.equalsIgnoreCase("standard")) scope.setAttribute("cascading","standard");
        else                                       scope.setAttribute("cascading","standard");
        
    }
    
    /**
     * sets the scope cascading type
     * @param type (ServletConfigImpl.SCOPE_XYZ)
     * @throws SecurityException
     */ 
    public void updateScopeCascadingType(short type) throws SecurityException {
    	checkWriteAccess();
        boolean hasAccess=ConfigWebUtil.hasAccess(config,SecurityManager.TYPE_SETTING);
        if(!hasAccess)
            throw new SecurityException("no access to update scope setting");
        
        //lucee.print.ln("********........type:"+type);
        Element scope=_getRootElement("scope");
        if(type==ConfigWeb.SCOPE_STRICT) scope.setAttribute("cascading","strict");
        else if(type==ConfigWeb.SCOPE_SMALL) scope.setAttribute("cascading","small");
        else if(type==ConfigWeb.SCOPE_STANDARD) scope.setAttribute("cascading","standard");
        
    }
    
    /**
     * sets if allowed implicid query call
     * @param allow
     * @throws SecurityException
     */
    public void updateAllowImplicidQueryCall(Boolean allow) throws SecurityException {
    	checkWriteAccess();
        boolean hasAccess=ConfigWebUtil.hasAccess(config,SecurityManager.TYPE_SETTING);
        
        if(!hasAccess) throw new SecurityException("no access to update scope setting");
        
        Element scope=_getRootElement("scope");
        scope.setAttribute("cascade-to-resultset",Caster.toString(allow,""));
        
    }
    
    public void updateMergeFormAndUrl(Boolean merge) throws SecurityException {
    	checkWriteAccess();
        boolean hasAccess=ConfigWebUtil.hasAccess(config,SecurityManager.TYPE_SETTING);
        
        if(!hasAccess) throw new SecurityException("no access to update scope setting");
        
        Element scope=_getRootElement("scope");
        scope.setAttribute("merge-url-form",Caster.toString(merge,""));
        
    }
    
    /**
     * updates request timeout value
     * @param span
     * @throws SecurityException
     * @throws ApplicationException 
     */
    public void updateRequestTimeout(TimeSpan span) throws SecurityException, ApplicationException {
    	checkWriteAccess();
        boolean hasAccess=ConfigWebUtil.hasAccess(config,SecurityManager.TYPE_SETTING);
        
        if(!hasAccess) throw new SecurityException("no access to update scope setting");
        
        Element scope=_getRootElement("scope");
        
        Element application=_getRootElement("application");
        if(span!=null){
        	if(span.getMillis()<=0)
        		throw new ApplicationException("value must be a positive number");
        	application.setAttribute("requesttimeout",span.getDay()+","+span.getHour()+","+span.getMinute()+","+span.getSecond());
        }
        else application.removeAttribute("requesttimeout");
        
        // remove deprecated attribute
        if(scope.hasAttribute("requesttimeout"))
        	scope.removeAttribute("requesttimeout");
    }
    
    /**
     * updates session timeout value
     * @param span
     * @throws SecurityException
     */
    public void updateSessionTimeout(TimeSpan span) throws SecurityException {
    	checkWriteAccess();
        boolean hasAccess=ConfigWebUtil.hasAccess(config,SecurityManager.TYPE_SETTING);
        
        if(!hasAccess) throw new SecurityException("no access to update scope setting");
        
        Element scope=_getRootElement("scope");
        if(span!=null)scope.setAttribute("sessiontimeout",span.getDay()+","+span.getHour()+","+span.getMinute()+","+span.getSecond());
        else scope.removeAttribute("sessiontimeout");
    }
    
    


	public void updateClientStorage(String storage) throws SecurityException, ApplicationException {
		updateStorage("client", storage);
	}


	public void updateSessionStorage(String storage) throws SecurityException, ApplicationException {
		updateStorage("session", storage);
	}
	

	private void updateStorage(String storageName,String storage) throws SecurityException, ApplicationException {
		checkWriteAccess();
        boolean hasAccess=ConfigWebUtil.hasAccess(config,SecurityManager.TYPE_SETTING);
        
        if(!hasAccess) throw new SecurityException("no access to update scope setting");
        storage=validateStorage(storage);
        
        
        Element scope=_getRootElement("scope");
        if(!StringUtil.isEmpty(storage,true))scope.setAttribute(storageName+"storage",storage);
        else scope.removeAttribute(storageName+"storage");
	}
    
    
    
    private String validateStorage(String storage) throws ApplicationException {
    	storage=storage.trim().toLowerCase();
        
    	// empty
    	if(StringUtil.isEmpty(storage,true)) return "";
    	
    	// standard storages
    	if("cookie".equals(storage) || "memory".equals(storage) || "file".equals(storage)) 
    		return storage;
    	
    	// aliases
    	if("ram".equals(storage)) return "memory";
    	if("registry".equals(storage)) return "file";
    	
    	// datasource
    	DataSource  ds = config.getDataSource(storage,null);
    	if(ds!=null) {
    		if(ds.isStorage())return storage;
    		throw new ApplicationException("datasource ["+storage+"] is not enabled to be used as session/client storage");
    	}
		
    	// cache
    	CacheConnection cc = Util.getCacheConnection(config, storage,null);
    	if(cc!=null) {
    		if(cc.isStorage())return storage;
    		throw new ApplicationException("cache ["+storage+"] is not enabled to be used as session/client storage");
    	}
    	
    	String sdx=StringUtil.soundex(storage);
    	
    	// check if a datasource has a similar name 
    	DataSource[] sources = config.getDataSources();
    	for(int i=0;i<sources.length;i++){
    		if(StringUtil.soundex(sources[i].getName()).equals(sdx))
    			throw new ApplicationException("no matching storage for ["+storage+"] found, did you mean ["+sources[i].getName()+"]");
    	}
    	
    	// check if a cache has a similar name 
    	Iterator<String> it = config.getCacheConnections().keySet().iterator();
    	String name;
    	while(it.hasNext()){
    		name=it.next();
    		if(StringUtil.soundex(name).equals(sdx))
    			throw new ApplicationException( "no matching storage for ["+storage+"] found, did you mean ["+name+"]");
    	}
    	
		
    	throw new ApplicationException("no matching storage for ["+storage+"] found");
	}


	/**
     * updates session timeout value
     * @param span
     * @throws SecurityException
     */
    public void updateClientTimeout(TimeSpan span) throws SecurityException {
    	checkWriteAccess();
        boolean hasAccess=ConfigWebUtil.hasAccess(config,SecurityManager.TYPE_SETTING);
        
        if(!hasAccess) throw new SecurityException("no access to update scope setting");
        
        Element scope=_getRootElement("scope");
        if(span!=null)scope.setAttribute("clienttimeout",span.getDay()+","+span.getHour()+","+span.getMinute()+","+span.getSecond());
        else scope.removeAttribute("clienttimeout");
        
        // deprecated
        if(scope.hasAttribute("client-max-age"))scope.removeAttribute("client-max-age");
       
        
    }
    

    public void updateCFMLWriterType(String writerType) throws SecurityException, ApplicationException {
    	checkWriteAccess();
    	boolean hasAccess=ConfigWebUtil.hasAccess(config,SecurityManager.TYPE_SETTING);
        if(!hasAccess) throw new SecurityException("no access to update scope setting");
        
        Element scope=_getRootElement("setting");
        writerType=writerType.trim();
        
        // remove
        if(StringUtil.isEmpty(writerType)) {
        	if(scope.hasAttribute("cfml-writer"))scope.removeAttribute("cfml-writer");
        	return;
        }
        
        // update
        if(!"white-space".equalsIgnoreCase(writerType) && 
        		!"white-space-pref".equalsIgnoreCase(writerType) && 
        		!"regular".equalsIgnoreCase(writerType))
        	throw new ApplicationException("invalid writer type defintion ["+writerType+"], valid types are [white-space, white-space-pref, regular]");
        
        scope.setAttribute("cfml-writer",writerType.toLowerCase());
    } 

    /*public void updateSuppressWhitespace(Boolean value) throws SecurityException {
    	checkWriteAccess();
        boolean hasAccess=ConfigWebUtil.hasAccess(config,SecurityManager.TYPE_SETTING);
        
        if(!hasAccess) throw new SecurityException("no access to update scope setting");
        
        Element scope=_getRootElement("setting");
        scope.setAttribute("suppress-whitespace",Caster.toString(value,""));
    }*/
    
    public void updateSuppressContent(Boolean value) throws SecurityException {
    	checkWriteAccess();
        boolean hasAccess=ConfigWebUtil.hasAccess(config,SecurityManager.TYPE_SETTING);
        
        if(!hasAccess) throw new SecurityException("no access to update scope setting");
        
        Element scope=_getRootElement("setting");
        scope.setAttribute("suppress-content",Caster.toString(value,""));
    }
    
    public void updateShowVersion(Boolean value) throws SecurityException {
    	checkWriteAccess();
        boolean hasAccess=ConfigWebUtil.hasAccess(config,SecurityManager.TYPE_SETTING);
        
        if(!hasAccess) throw new SecurityException("no access to update scope setting");
        
        Element scope=_getRootElement("setting");
        scope.setAttribute("show-version",Caster.toString(value,""));
    }
    
    public void updateAllowCompression(Boolean value) throws SecurityException {
    	checkWriteAccess();
        boolean hasAccess=ConfigWebUtil.hasAccess(config,SecurityManager.TYPE_SETTING);
        
        if(!hasAccess) throw new SecurityException("no access to update scope setting");
        
        Element scope=_getRootElement("setting");
        scope.setAttribute("allow-compression",Caster.toString(value,""));
    }
    
    public void updateContentLength(Boolean value) throws SecurityException {
    	checkWriteAccess();
        boolean hasAccess=ConfigWebUtil.hasAccess(config,SecurityManager.TYPE_SETTING);
        
        if(!hasAccess) throw new SecurityException("no access to update scope setting");
        
        Element scope=_getRootElement("setting");
        scope.setAttribute("content-length",Caster.toString(value,""));
    }
    

	public void updateBufferOutput(Boolean value) throws SecurityException {
		checkWriteAccess();
        boolean hasAccess=ConfigWebUtil.hasAccess(config,SecurityManager.TYPE_SETTING);
        
        if(!hasAccess) throw new SecurityException("no access to update scope setting");
        
        Element scope=_getRootElement("setting");
        scope.setAttribute("buffer-output",Caster.toString(value,""));
	}
    
    /**
     * updates request timeout value
     * @param span
     * @throws SecurityException
     */
    public void updateApplicationTimeout(TimeSpan span) throws SecurityException {
    	checkWriteAccess();
        boolean hasAccess=ConfigWebUtil.hasAccess(config,SecurityManager.TYPE_SETTING);
        
        if(!hasAccess) throw new SecurityException("no access to update scope setting");
        
        Element scope=_getRootElement("scope");
        if(span!=null)scope.setAttribute("applicationtimeout",span.getDay()+","+span.getHour()+","+span.getMinute()+","+span.getSecond());
        else scope.removeAttribute("applicationtimeout");
    }

    public void updateApplicationListener(String type,String mode) throws SecurityException {
    	checkWriteAccess();
        boolean hasAccess=ConfigWebUtil.hasAccess(config,SecurityManager.TYPE_SETTING);
        
        if(!hasAccess) throw new SecurityException("no access to update listener type");
        
        Element scope=_getRootElement("application");
        scope.setAttribute("listener-type",type.toLowerCase().trim());
        scope.setAttribute("listener-mode",mode.toLowerCase().trim());
    }
    
    public void updateProxy(boolean enabled,String server, int port, String username, String password) throws SecurityException {
    	checkWriteAccess();
        boolean hasAccess=ConfigWebUtil.hasAccess(config,SecurityManager.TYPE_SETTING);
        
        if(!hasAccess) throw new SecurityException("no access to update listener type");
        
        Element proxy=_getRootElement("proxy");
        proxy.setAttribute("enabled",Caster.toString(enabled));
        if(!StringUtil.isEmpty(server))		proxy.setAttribute("server",server);
        if(port>0)							proxy.setAttribute("port",Caster.toString(port));
        if(!StringUtil.isEmpty(username))	proxy.setAttribute("username",username);
        if(!StringUtil.isEmpty(password))	proxy.setAttribute("password",password);
    }
    
    /*public void removeProxy() throws SecurityException {
        boolean hasAccess=ConfigWebUtil.hasAccess(config,SecurityManager.TYPE_SETTING);
        if(!hasAccess) throw new SecurityException("no access to remove proxy settings");
        
        Element proxy=_getRootElement("proxy");
        proxy.removeAttribute("server");
        proxy.removeAttribute("port");
        proxy.removeAttribute("username");
        proxy.removeAttribute("password");
    }*/
    
    /**
     * enable or desable session management
     * @param sessionManagement
     * @throws SecurityException
     */
    public void updateSessionManagement(Boolean sessionManagement) throws SecurityException {
    	checkWriteAccess();
        boolean hasAccess=ConfigWebUtil.hasAccess(config,SecurityManager.TYPE_SETTING);
        
        if(!hasAccess)
            throw new SecurityException("no access to update scope setting");
        
        Element scope=_getRootElement("scope");
        scope.setAttribute("sessionmanagement",Caster.toString(sessionManagement,""));
    }
    
    /**
     * enable or desable client management
     * @param clientManagement
     * @throws SecurityException
     */
    public void updateClientManagement(Boolean clientManagement) throws SecurityException {
    	checkWriteAccess();
        boolean hasAccess=ConfigWebUtil.hasAccess(config,SecurityManager.TYPE_SETTING);
        
        if(!hasAccess)
            throw new SecurityException("no access to update scope setting");
        
        Element scope=_getRootElement("scope");
        scope.setAttribute("clientmanagement",Caster.toString(clientManagement,""));
    }
    
    /**
     * set if client cookies are enabled or not
     * @param clientCookies
     * @throws SecurityException
     */
    public void updateClientCookies(Boolean clientCookies) throws SecurityException {
    	checkWriteAccess();
        boolean hasAccess=ConfigWebUtil.hasAccess(config,SecurityManager.TYPE_SETTING);
        if(!hasAccess)
            throw new SecurityException("no access to update scope setting");
        
        Element scope=_getRootElement("scope");
        scope.setAttribute("setclientcookies",Caster.toString(clientCookies,""));
    }
    
    public void updateCGIReadonly(Boolean cgiReadonly) throws SecurityException {
    	checkWriteAccess();
        boolean hasAccess=ConfigWebUtil.hasAccess(config,SecurityManager.TYPE_SETTING);
        if(!hasAccess)
            throw new SecurityException("no access to update scope setting");
        
        Element scope=_getRootElement("scope");
        scope.setAttribute("cgi-readonly",Caster.toString(cgiReadonly,""));
    }
    
    /**
     * set if domain cookies are enabled or not
     * @param domainCookies
     * @throws SecurityException
     */
    public void updateDomaincookies(Boolean domainCookies) throws SecurityException {
    	checkWriteAccess();
        boolean hasAccess=ConfigWebUtil.hasAccess(config,SecurityManager.TYPE_SETTING);
        if(!hasAccess)
            throw new SecurityException("no access to update scope setting");
        
        Element scope=_getRootElement("scope");
        scope.setAttribute("setdomaincookies",Caster.toString(domainCookies,""));
    }
    
    /**
     * update the locale
     * @param locale
     * @throws SecurityException
     */
    public void updateLocale(String locale) throws SecurityException {
    	checkWriteAccess();
        boolean hasAccess=ConfigWebUtil.hasAccess(config,SecurityManager.TYPE_SETTING);
        if(!hasAccess)
            throw new SecurityException("no access to update regional setting");
        
        Element scope=_getRootElement("regional");
        scope.setAttribute("locale",locale.trim());
    }

    public void updateMonitorEnabled(boolean updateMonitorEnabled) throws SecurityException {
    	checkWriteAccess();
        
        Element scope=_getRootElement("monitoring");
        scope.setAttribute("enabled",Caster.toString(updateMonitorEnabled));
    }
    
    
    
    public void updateScriptProtect(String strScriptProtect) throws SecurityException {
    	checkWriteAccess();
        boolean hasAccess=ConfigWebUtil.hasAccess(config,SecurityManager.TYPE_SETTING);
        if(!hasAccess)
            throw new SecurityException("no access to update script protect");
        
        Element scope=_getRootElement("application");
        scope.setAttribute("script-protect",strScriptProtect.trim());
    }
    
    public void updateAllowURLRequestTimeout(Boolean allowURLRequestTimeout) throws SecurityException {
    	checkWriteAccess();
        boolean hasAccess=ConfigWebUtil.hasAccess(config,SecurityManager.TYPE_SETTING);
        if(!hasAccess)
            throw new SecurityException("no access to update AllowURLRequestTimeout");
        
        Element scope=_getRootElement("application");
        scope.setAttribute("allow-url-requesttimeout",Caster.toString(allowURLRequestTimeout,""));
    }

	public void updateQueue(Integer max, Integer timeout, Boolean enable) throws SecurityException {
		checkWriteAccess();
        boolean hasAccess=ConfigWebUtil.hasAccess(config,SecurityManager.TYPE_SETTING);
        if(!hasAccess) throw new SecurityException("no access to update queue settings");
        
        Element queue=_getRootElement("queue");
     // max
        if(max==null) queue.removeAttribute("max");
        else queue.setAttribute("max",Caster.toString(max,""));
     // total
        if(timeout==null) queue.removeAttribute("timeout");
        else queue.setAttribute("timeout",Caster.toString(timeout,""));
     // enable
        if(enable==null) queue.removeAttribute("enable");
        else queue.setAttribute("enable",Caster.toString(enable,""));
	}
    
    public void updateScriptProtect(int scriptProtect) throws SecurityException { 
    	updateScriptProtect(AppListenerUtil.translateScriptProtect(scriptProtect));
    }
    
    /**
     * update the timeZone
     * @param timeZone
     * @throws SecurityException
     */
    public void updateTimeZone(String timeZone) throws SecurityException {
    	checkWriteAccess();
        boolean hasAccess=ConfigWebUtil.hasAccess(config,SecurityManager.TYPE_SETTING);
        if(!hasAccess)
            throw new SecurityException("no access to update regional setting");
        
        Element regional=_getRootElement("regional");
        regional.setAttribute("timezone",timeZone.trim());
        
    }

    /**
     * update the timeServer
     * @param timeServer
     * @param useTimeServer 
     * @throws PageException 
     */
    public void updateTimeServer(String timeServer, Boolean useTimeServer) throws PageException {
    	checkWriteAccess();
        
       boolean hasAccess=ConfigWebUtil.hasAccess(config,SecurityManager.TYPE_SETTING);
       if(!hasAccess)
            throw new SecurityException("no access to update regional setting");
        
        Element scope=_getRootElement("regional");
        scope.setAttribute("timeserver",timeServer.trim());
        if(useTimeServer!=null)scope.setAttribute("use-timeserver",Caster.toString(useTimeServer));
        else scope.removeAttribute("use-timeserver");
    }
    
    /**
     * update the baseComponent
     * @param baseComponent
     * @throws SecurityException
     */
    public void updateBaseComponent(String baseComponent) throws SecurityException {
    	checkWriteAccess();
        boolean hasAccess=ConfigWebUtil.hasAccess(config,SecurityManager.TYPE_SETTING);
        if(!hasAccess)
            throw new SecurityException("no access to update component setting");
        //config.resetBaseComponentPage();
        Element scope=_getRootElement("component");
        //if(baseComponent.trim().length()>0)
        	scope.setAttribute("base",baseComponent);
    }
    
    

	public void updateComponentDeepSearch(Boolean deepSearch) throws SecurityException {
		checkWriteAccess();
	    boolean hasAccess=ConfigWebUtil.hasAccess(config,SecurityManager.TYPE_SETTING);
	    if(!hasAccess)
	        throw new SecurityException("no access to update component setting");
	    //config.resetBaseComponentPage();
	    Element scope=_getRootElement("component");
	    //if(baseComponent.trim().length()>0)
	    if(deepSearch!=null)
    	scope.setAttribute("deep-search",Caster.toString(deepSearch.booleanValue()));
	    
	    else {
	        if(scope.hasAttribute("deep-search"))
	        	scope.removeAttribute("deep-search");
	    }
		
	}
    

    public void updateComponentDefaultImport(String componentDefaultImport) throws SecurityException {
    	checkWriteAccess();
        boolean hasAccess=ConfigWebUtil.hasAccess(config,SecurityManager.TYPE_SETTING);
        if(!hasAccess)
            throw new SecurityException("no access to update component setting");
        //config.resetBaseComponentPage();
        Element scope=_getRootElement("component");
        //if(baseComponent.trim().length()>0)
        	scope.setAttribute("component-default-import",componentDefaultImport);
    }
    
    
    
    
    /**
     * update the Component Data Member default access type
     * @param access
     * @throws SecurityException
     * @throws ExpressionException 
     */
    public void updateComponentDataMemberDefaultAccess(String strAccess) throws SecurityException, ExpressionException {
    	checkWriteAccess(); 
        
    	
    	boolean hasAccess=ConfigWebUtil.hasAccess(config,SecurityManager.TYPE_SETTING);
        if(!hasAccess)
            throw new SecurityException("no access to update component setting");
        
        Element scope=_getRootElement("component");

        if(StringUtil.isEmpty(strAccess)){
        	scope.setAttribute("data-member-default-access","");
        }
        else{
	        scope.setAttribute("data-member-default-access",ComponentUtil.toStringAccess(ComponentUtil.toIntAccess(strAccess)));
        }
    } 
    
    /**
     * update the Component Data Member default access type
     * @param accessType
     * @throws SecurityException
     */
    public void updateTriggerDataMember(Boolean triggerDataMember) throws SecurityException {
    	checkWriteAccess();
        boolean hasAccess=ConfigWebUtil.hasAccess(config,SecurityManager.TYPE_SETTING);
        if(!hasAccess)
            throw new SecurityException("no access to update trigger-data-member");
        
        Element scope=_getRootElement("component");
        scope.setAttribute("trigger-data-member",Caster.toString(triggerDataMember,""));
    }

	public void updateComponentUseShadow(Boolean useShadow) throws SecurityException {
    	checkWriteAccess();
		boolean hasAccess=ConfigWebUtil.hasAccess(config,SecurityManager.TYPE_SETTING);
		if(!hasAccess)
            throw new SecurityException("no access to update use-shadow");
        
        Element scope=_getRootElement("component");
        scope.setAttribute("use-shadow",Caster.toString(useShadow,""));
	}

	public void updateComponentLocalSearch(Boolean componentLocalSearch) throws SecurityException {
    	checkWriteAccess();
		boolean hasAccess=ConfigWebUtil.hasAccess(config,SecurityManager.TYPE_SETTING);
		if(!hasAccess)
            throw new SecurityException("no access to update component Local Search");
        
        Element scope=_getRootElement("component");
        scope.setAttribute("local-search",Caster.toString(componentLocalSearch,""));
	}
	
	public void updateComponentPathCache(Boolean componentPathCache) throws SecurityException {
		checkWriteAccess();
		boolean hasAccess=ConfigWebUtil.hasAccess(config,SecurityManager.TYPE_SETTING);
		if(!hasAccess)
            throw new SecurityException("no access to update component Cache Path");
        
        Element scope=_getRootElement("component");
        if(!Caster.toBooleanValue(componentPathCache,false))
        	config.clearComponentCache();
        scope.setAttribute("use-cache-path",Caster.toString(componentPathCache,""));
	}
	public void updateCTPathCache(Boolean ctPathCache) throws SecurityException {
		checkWriteAccess();
		if(!ConfigWebUtil.hasAccess(config, SecurityManager.TYPE_CUSTOM_TAG)) 
			throw new SecurityException("no access to update custom tag setting");
		
		 if(!Caster.toBooleanValue(ctPathCache,false))
	        	config.clearCTCache();
	        Element scope=_getRootElement("custom-tag");
        scope.setAttribute("use-cache-path",Caster.toString(ctPathCache,""));
	}

	
	
	
    /**
     * updates if debugging or not
     * @param debug if value is null server setting is used
     * @throws SecurityException
     */
    public void updateDebug(Boolean debug, Boolean database, Boolean exception, Boolean tracing, Boolean dump, Boolean timer, 
    		Boolean implicitAccess, Boolean queryUsage) throws SecurityException {
    	checkWriteAccess();
        boolean hasAccess=ConfigWebUtil.hasAccess(config,SecurityManager.TYPE_DEBUGGING);
        if(!hasAccess)
            throw new SecurityException("no access to change debugging settings");
        Element debugging=_getRootElement("debugging");
        
        if(debug!=null)debugging.setAttribute("debug",Caster.toString(debug.booleanValue()));
        else debugging.removeAttribute("debug");
        
        if(database!=null)debugging.setAttribute("database",Caster.toString(database.booleanValue()));
        else debugging.removeAttribute("database");
        
        if(exception!=null)debugging.setAttribute("exception",Caster.toString(exception.booleanValue()));
        else debugging.removeAttribute("exception");
        
        if(tracing!=null)debugging.setAttribute("tracing",Caster.toString(tracing.booleanValue()));
        else debugging.removeAttribute("tracing");
        
        if(dump!=null)debugging.setAttribute("dump",Caster.toString(dump.booleanValue()));
        else debugging.removeAttribute("dump");
        
        if(timer!=null)debugging.setAttribute("timer",Caster.toString(timer.booleanValue()));
        else debugging.removeAttribute("timer");

        if(implicitAccess!=null)debugging.setAttribute("implicit-access",Caster.toString(implicitAccess.booleanValue()));
        else debugging.removeAttribute("implicit-access");
        
        if(queryUsage!=null)debugging.setAttribute("query-usage",Caster.toString(queryUsage.booleanValue()));
        else debugging.removeAttribute("query-usage");
        
        
    }

    /**
     * updates the DebugTemplate
     * @param template
     * @throws SecurityException
     */
    public void updateDebugTemplate(String template) throws SecurityException {
    	checkWriteAccess();
        boolean hasAccess=ConfigWebUtil.hasAccess(config,SecurityManager.TYPE_DEBUGGING);
        if(!hasAccess)
            throw new SecurityException("no access to change debugging settings");

        Element debugging=_getRootElement("debugging");
        //if(template.trim().length()>0)
        	debugging.setAttribute("template",template);
    }
    
    /**
     * updates the ErrorTemplate
     * @param template
     * @throws SecurityException
     */
    public void updateErrorTemplate(int statusCode,String template) throws SecurityException {
    	checkWriteAccess();
        boolean hasAccess=ConfigWebUtil.hasAccess(config,SecurityManager.TYPE_DEBUGGING);
        if(!hasAccess)
            throw new SecurityException("no access to change error settings");

        Element error=_getRootElement("error");
        //if(template.trim().length()>0)
        	error.setAttribute("template-"+statusCode,template);
    }
    

    public void updateErrorStatusCode(Boolean doStatusCode) throws SecurityException {
    	checkWriteAccess();
        boolean hasAccess=ConfigWebUtil.hasAccess(config,SecurityManager.TYPE_DEBUGGING);
        if(!hasAccess)
            throw new SecurityException("no access to change error settings");

        Element error=_getRootElement("error");
        error.setAttribute("status-code",Caster.toString(doStatusCode,""));
    }

    /**
     * updates the DebugTemplate
     * @param template
     * @throws SecurityException
     */
    public void updateComponentDumpTemplate(String template) throws SecurityException {
    	checkWriteAccess();
        boolean hasAccess=ConfigWebUtil.hasAccess(config,SecurityManager.TYPE_SETTING);
        if(!hasAccess)
            throw new SecurityException("no access to update component setting");
        
        Element component=_getRootElement("component");
        //if(template.trim().length()>0)
        	component.setAttribute("dump-template",template);
    }
    
    /* *
     * updates the if memory usage will be logged or not
     * @param logMemoryUsage
     * @throws SecurityException
     * /
    public void updateLogMemoryUsage(boolean logMemoryUsage) throws SecurityException {
        boolean hasAccess=ConfigWebUtil.hasAccess(config,SecurityManager.TYPE_DEBUGGING);
        if(!hasAccess)
            throw new SecurityException("no access to change debugging settings");
        
        Element debugging=_getRootElement("debugging");
        debugging.setAttribute("log-memory-usage",Caster.toString(logMemoryUsage));
    }*/
    
    /* *
     * updates the Memory Logger
     * @param memoryLogger
     * @throws SecurityException
     * /
    public void updateMemoryLogger(String memoryLogger) throws SecurityException {
        boolean hasAccess=ConfigWebUtil.hasAccess(config,SecurityManager.TYPE_DEBUGGING);
        if(!hasAccess)
            throw new SecurityException("no access to change debugging settings");
        
        Element debugging=_getRootElement("debugging");
        if(memoryLogger.trim().length()>0)debugging.setAttribute("memory-log",memoryLogger);
    }*/

    private Element _getRootElement(String name) {
        Element el=ConfigWebFactory.getChildByName(doc.getDocumentElement(),name);
        if(el==null) {
            el=doc.createElement(name);
            doc.getDocumentElement().appendChild(el);
        }
        return el;
    }

    private Element _getRootElement(String name, boolean insertBefore,boolean doNotCreate) {
        return ConfigWebFactory.getChildByName(doc.getDocumentElement(),name,insertBefore,doNotCreate);
    }
    
    /**
     * @param setting
     * @param file
     * @param directJavaAccess
     * @param mail
     * @param datasource
     * @param mapping
     * @param customTag
     * @param cfxSetting
     * @param cfxUsage
     * @param debugging
     * @param search 
     * @param scheduledTasks 
     * @param tagExecute
     * @param tagImport
     * @param tagObject
     * @param tagRegistry
     * @throws SecurityException
     */
    public void updateDefaultSecurity(short setting, short file,Resource[] fileAccess,short directJavaAccess,
 	       short mail, short datasource, short mapping, short remote, short customTag,
 	      short cfxSetting, short cfxUsage, short debugging,
         short search, short scheduledTasks,
         short tagExecute,short tagImport, short tagObject, short tagRegistry,
         short cache, short gateway,short orm,
         short accessRead, short accessWrite) throws SecurityException {
    	checkWriteAccess();
        if(!(config instanceof ConfigServer))
            throw new SecurityException("can't change security settings from this context");
        
        Element security=_getRootElement("security");
        updateSecurityFileAccess(security,fileAccess,file);
        security.setAttribute("setting",            SecurityManagerImpl.toStringAccessValue(setting));
        security.setAttribute("file",               SecurityManagerImpl.toStringAccessValue(file));
        security.setAttribute("direct_java_access", SecurityManagerImpl.toStringAccessValue(directJavaAccess));
        security.setAttribute("mail",               SecurityManagerImpl.toStringAccessValue(mail));
        security.setAttribute("datasource",         SecurityManagerImpl.toStringAccessValue(datasource));
        security.setAttribute("mapping",            SecurityManagerImpl.toStringAccessValue(mapping));
        security.setAttribute("remote",            	SecurityManagerImpl.toStringAccessValue(remote));
        security.setAttribute("custom_tag",         SecurityManagerImpl.toStringAccessValue(customTag));
        security.setAttribute("cfx_setting",        SecurityManagerImpl.toStringAccessValue(cfxSetting));
        security.setAttribute("cfx_usage",          SecurityManagerImpl.toStringAccessValue(cfxUsage));
        security.setAttribute("debugging",          SecurityManagerImpl.toStringAccessValue(debugging));
        security.setAttribute("search",             SecurityManagerImpl.toStringAccessValue(search));
        security.setAttribute("scheduled_task",     SecurityManagerImpl.toStringAccessValue(scheduledTasks));

        security.setAttribute("tag_execute",        SecurityManagerImpl.toStringAccessValue(tagExecute));
        security.setAttribute("tag_import",         SecurityManagerImpl.toStringAccessValue(tagImport));
        security.setAttribute("tag_object",         SecurityManagerImpl.toStringAccessValue(tagObject));
        security.setAttribute("tag_registry",         SecurityManagerImpl.toStringAccessValue(tagRegistry));
        security.setAttribute("cache",       SecurityManagerImpl.toStringAccessValue(cache));
        security.setAttribute("gateway",       SecurityManagerImpl.toStringAccessValue(gateway));
        security.setAttribute("orm",       SecurityManagerImpl.toStringAccessValue(orm));

        security.setAttribute("access_read",       SecurityManagerImpl.toStringAccessRWValue(accessRead));
        security.setAttribute("access_write",      SecurityManagerImpl.toStringAccessRWValue(accessWrite));
    
    
    
    }
    
    private void removeSecurityFileAccess(Element parent) {
    	Element[] children = ConfigWebFactory.getChildren(parent,"file-access");
      	
    	// remove existing
    	if(!ArrayUtil.isEmpty(children)){
    		for(int i=children.length-1;i>=0;i--){
	    		parent.removeChild(children[i]);
	    	}
    	}
    }
    
    private void updateSecurityFileAccess(Element parent,Resource[] fileAccess, short file) {
    	removeSecurityFileAccess(parent);
    	
    	// insert
    	if(!ArrayUtil.isEmpty(fileAccess) && file!=SecurityManager.VALUE_ALL){
    		Element fa;
	    	for(int i=0;i<fileAccess.length;i++){
	    		fa=doc.createElement("file-access");
	    		fa.setAttribute("path", fileAccess[i].getAbsolutePath());
	    		parent.appendChild(fa);
	    	}
    	}
    	
	}


	/**
     * update a security manager that match the given id
     * @param id
     * @param setting
     * @param file
     * @param file_access 
     * @param directJavaAccess
     * @param mail
     * @param datasource
     * @param mapping
     * @param customTag
     * @param cfxSetting
     * @param cfxUsage
     * @param debugging
     * @param search 
     * @param scheduledTasks 
     * @param tagExecute
     * @param tagImport
     * @param tagObject
     * @param tagRegistry
     * @throws SecurityException
     * @throws ApplicationException
     */
    public void updateSecurity(String id, short setting, short file,Resource[] fileAccess, short directJavaAccess,
           short mail, short datasource, short mapping, short remote, short customTag,
          short cfxSetting, short cfxUsage, short debugging,
          short search, short scheduledTasks,
          short tagExecute,short tagImport, short tagObject, short tagRegistry, 
          short cache,short gateway,short orm,
          short accessRead, short accessWrite) throws SecurityException, ApplicationException {
    	checkWriteAccess();
        if(!(config instanceof ConfigServer))
            throw new SecurityException("can't change security settings from this context");
        
        Element security=_getRootElement("security");
        Element[] children = ConfigWebFactory.getChildren(security,"accessor");
        Element accessor=null;
        for(int i=0;i<children.length;i++) {
            if(id.equals(children[i].getAttribute("id"))) {
                accessor=children[i];
            }
        }
        if(accessor==null) throw new ApplicationException("there is noc Security Manager for id ["+id+"]");
        updateSecurityFileAccess(accessor,fileAccess,file);
        
        accessor.setAttribute("setting",            SecurityManagerImpl.toStringAccessValue(setting));
        accessor.setAttribute("file",               SecurityManagerImpl.toStringAccessValue(file));
        accessor.setAttribute("direct_java_access", SecurityManagerImpl.toStringAccessValue(directJavaAccess));
        accessor.setAttribute("mail",               SecurityManagerImpl.toStringAccessValue(mail));
        accessor.setAttribute("datasource",         SecurityManagerImpl.toStringAccessValue(datasource));
        accessor.setAttribute("mapping",            SecurityManagerImpl.toStringAccessValue(mapping));
        accessor.setAttribute("remote",            	SecurityManagerImpl.toStringAccessValue(remote));
        accessor.setAttribute("custom_tag",         SecurityManagerImpl.toStringAccessValue(customTag));
        accessor.setAttribute("cfx_setting",        SecurityManagerImpl.toStringAccessValue(cfxSetting));
        accessor.setAttribute("cfx_usage",          SecurityManagerImpl.toStringAccessValue(cfxUsage));
        accessor.setAttribute("debugging",          SecurityManagerImpl.toStringAccessValue(debugging));
        accessor.setAttribute("search",             SecurityManagerImpl.toStringAccessValue(search));
        accessor.setAttribute("scheduled_task",     SecurityManagerImpl.toStringAccessValue(scheduledTasks));
        accessor.setAttribute("cache",     SecurityManagerImpl.toStringAccessValue(cache));
        accessor.setAttribute("gateway",     SecurityManagerImpl.toStringAccessValue(gateway));
        accessor.setAttribute("orm",     SecurityManagerImpl.toStringAccessValue(orm));
        
        accessor.setAttribute("tag_execute",        SecurityManagerImpl.toStringAccessValue(tagExecute));
        accessor.setAttribute("tag_import",         SecurityManagerImpl.toStringAccessValue(tagImport));
        accessor.setAttribute("tag_object",         SecurityManagerImpl.toStringAccessValue(tagObject));
        accessor.setAttribute("tag_registry",       SecurityManagerImpl.toStringAccessValue(tagRegistry));

        accessor.setAttribute("access_read",       SecurityManagerImpl.toStringAccessRWValue(accessRead));
        accessor.setAttribute("access_write",      SecurityManagerImpl.toStringAccessRWValue(accessWrite));
    }
    
    
    
    
    /**
     * @return returns the default password
     * @throws SecurityException
     */
    public Password getDefaultPassword() throws SecurityException {
    	checkReadAccess();
        if(config instanceof ConfigServerImpl) {
            return ((ConfigServerImpl)config).getDefaultPassword();
        }
        throw new SecurityException("can't access default password within this context");
    }
    /**
     * @param password
     * @throws SecurityException 
     * @throws IOException 
     * @throws DOMException 
     */
    public void updateDefaultPassword(String password) throws SecurityException, DOMException, IOException {
    	checkWriteAccess();
        ((ConfigServerImpl)config).setDefaultPassword(Password.hashAndStore(doc.getDocumentElement(),password,true));
		
    }

	public void removeDefaultPassword() throws SecurityException {
		checkWriteAccess();
        Element root=doc.getDocumentElement();
        Password.remove(root,true);
        ((ConfigServerImpl)config).setDefaultPassword(null);
	}
    
    /**
     * session type update
     * @param type
     * @throws SecurityException
     */
    public void updateSessionType(String type) throws SecurityException {
    	checkWriteAccess();
        boolean hasAccess=ConfigWebUtil.hasAccess(config,SecurityManager.TYPE_SETTING);
        if(!hasAccess) throw new SecurityException("no access to update scope setting");
        
        type=type.toLowerCase().trim();
        
        Element scope=_getRootElement("scope");
        scope.setAttribute("session-type",type);
    }
    
    public void updateLocalMode(String mode) throws SecurityException {
    	checkWriteAccess();
        boolean hasAccess=ConfigWebUtil.hasAccess(config,SecurityManager.TYPE_SETTING);
        if(!hasAccess) throw new SecurityException("no access to update scope setting");
        
        mode=mode.toLowerCase().trim();
        Element scope=_getRootElement("scope");
        scope.setAttribute("local-mode",mode);
    }
    



	public void updateRestList(Boolean list) throws SecurityException {
		checkWriteAccess();
        boolean hasAccess=true;// TODO ConfigWebUtil.hasAccess(config,SecurityManager.TYPE_REST);
        if(!hasAccess) throw new SecurityException("no access to update rest setting");
        
        
        Element rest=_getRootElement("rest");
        if(list==null) {
        	if(rest.hasAttribute("list"))rest.removeAttribute("list");
        }
        else rest.setAttribute("list", Caster.toString(list.booleanValue()));
	}
	
	/*public void updateRestAllowChanges(Boolean allowChanges) throws SecurityException {
		checkWriteAccess();
        boolean hasAccess=true;// TODO ConfigWebUtil.hasAccess(config,SecurityManager.TYPE_REST);
        if(!hasAccess) throw new SecurityException("no access to update rest setting");
        
        
        Element rest=_getRootElement("rest");
        if(allowChanges==null) {
        	if(rest.hasAttribute("allow-changes"))rest.removeAttribute("allow-changes");
        }
        else rest.setAttribute("allow-changes", Caster.toString(allowChanges.booleanValue()));
	}*/
	

    /**
     * updates update settingd for lucee
     * @param type
     * @param location
     * @throws SecurityException
     */
    public void updateUpdate(String type, String location) throws SecurityException {
    	checkWriteAccess();
        
        if(!(config instanceof ConfigServer)) {
            throw new SecurityException("can't change update setting from this context, access is denied");
        }
        Element update=_getRootElement("update");
        update.setAttribute("type",type);
        try {
			location=HTTPUtil.toURL(location,true).toString();
		} 
        catch (Throwable e) {}
        update.setAttribute("location",location);
    }
    
    /**
     * creates a individual security manager based on the default security manager
     * @param id
     * @throws DOMException 
     * @throws PageException 
     */
    public void createSecurityManager(String password,String id) throws DOMException, PageException {
    	checkWriteAccess();
    	ConfigServerImpl cs=(ConfigServerImpl) config.getConfigServer(password);
        SecurityManagerImpl dsm = (SecurityManagerImpl) cs.getDefaultSecurityManager().cloneSecurityManager();
        cs.setSecurityManager(id,dsm);
        
        Element security=_getRootElement("security");
        Element accessor=null;
        
        Element[] children = ConfigWebFactory.getChildren(security,"accessor");
        for(int i=0;i<children.length;i++) {
            if(id.equals(children[i].getAttribute("id"))) {
                accessor=children[i];             
            }
        }
        if(accessor==null) {
            accessor=doc.createElement("accessor");
            security.appendChild(accessor);
        }
        
        updateSecurityFileAccess(accessor,dsm.getCustomFileAccess(),dsm.getAccess(SecurityManager.TYPE_FILE));
        
        
        accessor.setAttribute("id",id);
        accessor.setAttribute("setting",            SecurityManagerImpl.toStringAccessValue(dsm.getAccess(SecurityManager.TYPE_SETTING)));
        accessor.setAttribute("file",               SecurityManagerImpl.toStringAccessValue(dsm.getAccess(SecurityManager.TYPE_FILE)));
        accessor.setAttribute("direct_java_access", SecurityManagerImpl.toStringAccessValue(dsm.getAccess(SecurityManager.TYPE_DIRECT_JAVA_ACCESS)));
        accessor.setAttribute("mail",               SecurityManagerImpl.toStringAccessValue(dsm.getAccess(SecurityManager.TYPE_MAIL)));
        accessor.setAttribute("datasource",         SecurityManagerImpl.toStringAccessValue(dsm.getAccess(SecurityManager.TYPE_DATASOURCE)));
        accessor.setAttribute("mapping",            SecurityManagerImpl.toStringAccessValue(dsm.getAccess(SecurityManager.TYPE_MAPPING)));
        accessor.setAttribute("custom_tag",         SecurityManagerImpl.toStringAccessValue(dsm.getAccess(SecurityManager.TYPE_CUSTOM_TAG)));
        accessor.setAttribute("cfx_setting",        SecurityManagerImpl.toStringAccessValue(dsm.getAccess(SecurityManager.TYPE_CFX_SETTING)));
        accessor.setAttribute("cfx_usage",          SecurityManagerImpl.toStringAccessValue(dsm.getAccess(SecurityManager.TYPE_CFX_USAGE)));
        accessor.setAttribute("debugging",          SecurityManagerImpl.toStringAccessValue(dsm.getAccess(SecurityManager.TYPE_DEBUGGING)));
        accessor.setAttribute("cache",          	SecurityManagerImpl.toStringAccessValue(dsm.getAccess(SecurityManagerImpl.TYPE_CACHE)));
        accessor.setAttribute("gateway",          	SecurityManagerImpl.toStringAccessValue(dsm.getAccess(SecurityManagerImpl.TYPE_GATEWAY)));
        accessor.setAttribute("orm",          		SecurityManagerImpl.toStringAccessValue(dsm.getAccess(SecurityManagerImpl.TYPE_ORM)));

        accessor.setAttribute("tag_execute",        SecurityManagerImpl.toStringAccessValue(dsm.getAccess(SecurityManager.TYPE_TAG_EXECUTE)));
        accessor.setAttribute("tag_import",         SecurityManagerImpl.toStringAccessValue(dsm.getAccess(SecurityManager.TYPE_TAG_IMPORT)));
        accessor.setAttribute("tag_object",         SecurityManagerImpl.toStringAccessValue(dsm.getAccess(SecurityManager.TYPE_TAG_OBJECT)));
        accessor.setAttribute("tag_registry",       SecurityManagerImpl.toStringAccessValue(dsm.getAccess(SecurityManager.TYPE_TAG_REGISTRY)));
        
    }


    /**
     * remove security manager matching given id
     * @param id
     * @throws PageException 
     */
    public void removeSecurityManager(String password,String id) throws PageException {
    	checkWriteAccess();
        ((ConfigServerImpl)config.getConfigServer(password)).removeSecurityManager(id);
        
        Element security=_getRootElement("security");
       
        
        Element[] children = ConfigWebFactory.getChildren(security,"accessor");
        for(int i=0;i<children.length;i++) {
            if(id.equals(children[i].getAttribute("id"))) {
                security.removeChild(children[i]);
            }
        }
    }

    /**
     * run update from cfml engine
     * @throws PageException
     */
    public void runUpdate(String password) throws PageException {
    	checkWriteAccess();
        ConfigServerImpl cs = (ConfigServerImpl) config.getConfigServer(password);
        CFMLEngineFactory factory = cs.getCFMLEngine().getCFMLEngineFactory();
        synchronized(factory){
	        try {
	            factory.update(cs.getPassword().password);
	        } 
	        catch (Exception e) {
	            throw Caster.toPageException(e);
	        }
        }
        
    }
    
    /**
     * run update from cfml engine
     * @throws PageException
     */
    public void removeLatestUpdate(String password) throws PageException {
    	_removeUpdate(password,true);
    }
    
    public void removeUpdate(String password) throws PageException {
    	_removeUpdate(password,false);
    }
    
    private void _removeUpdate(String password,boolean onlyLatest) throws PageException {
    	checkWriteAccess();
    	ConfigServerImpl cs = (ConfigServerImpl) config.getConfigServer(password);
        try {
        	CFMLEngineFactory factory = cs.getCFMLEngine().getCFMLEngineFactory();
        	
        	if(onlyLatest){
        		try{
        			factory.removeLatestUpdate(cs.getPassword().password);
        		}
        		catch(Throwable t)	{
        			removeLatestUpdateOld(factory,cs.getPassword().password);
        		}
        	}
        	else factory.removeUpdate(cs.getPassword().password);
        	
        	
        } 
        catch (Exception e) {
            throw Caster.toPageException(e);
        }
    }
    
	private String getCoreExtension() {
    	return "lco";
	}
	
	private boolean isNewerThan(int left, int right) {
        return left>right;
    }
	
    private boolean removeLatestUpdateOld(CFMLEngineFactory factory, String password) throws IOException, ServletException {
    	File patchDir = new File(factory.getResourceRoot(),"patches");
        if(!patchDir.exists())patchDir.mkdirs();
        
    	File[] patches=patchDir.listFiles(new ExtensionFilter(new String[]{"."+getCoreExtension()}));
        File patch=null;
        for(int i=0;i<patches.length;i++) {
        	 if(patch==null || isNewerThan(lucee.loader.util.Util.toInVersion(patches[i].getName()),lucee.loader.util.Util.toInVersion(patch.getName()))) {
                 patch=patches[i];
             }
        }
    	if(patch!=null && !patch.delete())patch.deleteOnExit();
        factory.restart(password);
        return true;
    }
    
    
    /*private Resource getPatchDirectory(CFMLEngine engine) throws IOException {
    	//File f=engine.getCFMLEngineFactory().getResourceRoot();
    	Resource res = ResourcesImpl.getFileResourceProvider().getResource(engine.getCFMLEngineFactory().getResourceRoot().getAbsolutePath());
    	Resource pd = res.getRealResource("patches");
        if(!pd.exists())pd.mkdirs();
        return pd;
    }*/
    
    
    
    
    /**
     * run update from cfml engine
     * @throws PageException
     */
    public void restart(String password) throws PageException {
    	checkWriteAccess();
        ConfigServerImpl cs = (ConfigServerImpl) config.getConfigServer(password);
        CFMLEngineFactory factory = cs.getCFMLEngine().getCFMLEngineFactory();
        synchronized(factory){
	        try {
	            factory.restart(cs.getPassword().password);
	        } 
	        catch (Exception e) {
	            throw Caster.toPageException(e);
	        }
        }
    }

	public void updateWebCharset(String charset) throws PageException {
    	checkWriteAccess();
		
    	Element element = _getRootElement("charset");
		if(StringUtil.isEmpty(charset)){
			if(config instanceof ConfigWeb)
				element.removeAttribute("web-charset");
			else
				element.setAttribute("web-charset", "UTF-8");
		}
		else {
			charset=checkCharset(charset);
			element.setAttribute("web-charset", charset);
		}
    	
		element = _getRootElement("regional");
		element.removeAttribute("default-encoding");// remove deprecated attribute
		
	}

	public void updateResourceCharset(String charset) throws PageException {
    	checkWriteAccess();
    	
    	Element element = _getRootElement("charset");
		if(StringUtil.isEmpty(charset)){
			element.removeAttribute("resource-charset");
		}
		else {
			charset=checkCharset(charset);
			element.setAttribute("resource-charset", charset);
			
		}
    	
		// update charset
		
	}

	public void updateTemplateCharset(String charset) throws PageException {
		
    	checkWriteAccess();
    	
    	Element element = _getRootElement("charset");
		if(StringUtil.isEmpty(charset,true)){
			element.removeAttribute("template-charset");
		}
		else {
			charset=checkCharset(charset);
			element.setAttribute("template-charset", charset);
		}
	}
	
	private String checkCharset(String charset)  throws PageException{
		charset=charset.trim();
		if("system".equalsIgnoreCase(charset))
			charset=SystemUtil.getCharset().name();
		else if("jre".equalsIgnoreCase(charset))
			charset=SystemUtil.getCharset().name();
		else if("os".equalsIgnoreCase(charset))
			charset=SystemUtil.getCharset().name();
		
		// check access
		boolean hasAccess = ConfigWebUtil.hasAccess(config, SecurityManager.TYPE_SETTING);
		if(!hasAccess) {
			throw new SecurityException("no access to update regional setting");
		}
		
		// check encoding
		try {
			IOUtil.checkEncoding(charset);
		}
		catch (IOException e) {throw Caster.toPageException(e);}
		return charset;
	}


	private Resource getStoragDir(Config config) {
    	Resource storageDir = config.getConfigDir().getRealResource("storage");
		if(!storageDir.exists())storageDir.mkdirs();
		return storageDir;
	}
	
	public void storageSet(Config config,String key, Object value) throws ConverterException, IOException, SecurityException {
    	checkWriteAccess();
		Resource storageDir = getStoragDir(config);
		Resource storage=storageDir.getRealResource(key+".wddx");
		
		WDDXConverter converter =new WDDXConverter(config.getTimeZone(),true,true);
		String wddx=converter.serialize(value);
		IOUtil.write(storage, wddx, "UTF-8", false);
	}


	public Object storageGet(Config config, String key) throws ConverterException, IOException, SecurityException {
    	checkReadAccess();
		Resource storageDir = getStoragDir(config);
		Resource storage=storageDir.getRealResource(key+".wddx");
		if(!storage.exists()) throw new IOException("there is no storage with name "+key);
		WDDXConverter converter =new WDDXConverter(config.getTimeZone(),true,true);
		return converter.deserialize(IOUtil.toString(storage,"UTF-8"), true);
	}


	public void updateCustomTagDeepSearch(boolean customTagDeepSearch) throws SecurityException {
		checkWriteAccess();
		if(!ConfigWebUtil.hasAccess(config, SecurityManager.TYPE_CUSTOM_TAG)) 
			throw new SecurityException("no access to update custom tag setting");
		
		Element element = _getRootElement("custom-tag");
		element.setAttribute("custom-tag-deep-search",Caster.toString(customTagDeepSearch));
	}

	public void resetId() throws PageException {
		checkWriteAccess();
		Resource res=config.getConfigDir().getRealResource("id");
		try {
			if(res.exists())res.remove(false);
		} catch (IOException e) {
			throw Caster.toPageException(e);
		}
    	
	}
	
	public void updateCustomTagLocalSearch(boolean customTagLocalSearch) throws SecurityException {
		checkWriteAccess();
		if(!ConfigWebUtil.hasAccess(config, SecurityManager.TYPE_CUSTOM_TAG)) 
			throw new SecurityException("no access to update custom tag setting");
		
		Element element = _getRootElement("custom-tag");
		element.setAttribute("custom-tag-local-search",Caster.toString(customTagLocalSearch));
	}
	


	public void updateCustomTagExtensions(String extensions) throws PageException {
		checkWriteAccess();
		if(!ConfigWebUtil.hasAccess(config, SecurityManager.TYPE_CUSTOM_TAG)) 
			throw new SecurityException("no access to update custom tag setting");
		
		// check
		Array arr = ListUtil.listToArrayRemoveEmpty(extensions, ',');
		ListUtil.trimItems(arr);
		//throw new ApplicationException("you must define at least one extension");
		
		
		// update charset
		Element element = _getRootElement("custom-tag");
		element.setAttribute("extensions",ListUtil.arrayToList(arr, ","));
	}


	public void updateRemoteClient(String label,String url, String type,
			String securityKey, String usage, String adminPassword, String serverUsername, String serverPassword,
			String proxyServer, String proxyUsername, String proxyPassword, String proxyPort) throws PageException {
		checkWriteAccess();
		
		// SNSN
		
		boolean hasAccess=ConfigWebUtil.hasAccess(config,SecurityManagerImpl.TYPE_REMOTE);
        if(!hasAccess)
            throw new SecurityException("no access to update remote client settings");
        
        
        Element clients=_getRootElement("remote-clients");
        
        if(StringUtil.isEmpty(url)) throw new ExpressionException("url can be a empty value");
        if(StringUtil.isEmpty(securityKey)) throw new ExpressionException("securityKey can be a empty value");
        if(StringUtil.isEmpty(adminPassword)) throw new ExpressionException("adminPassword can be a empty value");
        url=url.trim();
        securityKey=securityKey.trim();
        adminPassword=adminPassword.trim();
        
        Element[] children = ConfigWebFactory.getChildren(clients,"remote-client");
      	
        // Update
        for(int i=0;i<children.length;i++) {
      	    Element el=children[i];
      	    String _url=el.getAttribute("url");
  			if(_url!=null && _url.equalsIgnoreCase(url)) {
  				el.setAttribute("label",label);
  				el.setAttribute("type",type);
	      		el.setAttribute("usage",usage);
	      		el.setAttribute("server-username",serverUsername);
	      		el.setAttribute("proxy-server",proxyServer);
	      		el.setAttribute("proxy-username",proxyUsername);
	      		el.setAttribute("proxy-port",proxyPort);
	      		el.setAttribute("security-key",ConfigWebFactory.encrypt(securityKey));
	      		el.setAttribute("admin-password",ConfigWebFactory.encrypt(adminPassword));
	      		el.setAttribute("server-password",ConfigWebFactory.encrypt(serverPassword));
	      		el.setAttribute("proxy-password",ConfigWebFactory.encrypt(proxyPassword));
	      		return ;
  			}
      	}
        
        // Insert
      	Element el = doc.createElement("remote-client");

      	el.setAttribute("label",label);
		el.setAttribute("url",url);
  		el.setAttribute("type",type);
  		el.setAttribute("usage",usage);
  		el.setAttribute("server-username",serverUsername);
  		el.setAttribute("proxy-server",proxyServer);
  		el.setAttribute("proxy-username",proxyUsername);
  		el.setAttribute("proxy-port",proxyPort);
  		el.setAttribute("security-key",ConfigWebFactory.encrypt(securityKey));
  		el.setAttribute("admin-password",ConfigWebFactory.encrypt(adminPassword));
  		el.setAttribute("server-password",ConfigWebFactory.encrypt(serverPassword));
  		el.setAttribute("proxy-password",ConfigWebFactory.encrypt(proxyPassword));
      	
      	
      	clients.appendChild(el);
	}

	public void updateMonitor(String className,String type, String name, boolean logEnabled) throws PageException {
		checkWriteAccess();
		
        Element parent=_getRootElement("monitoring");
        
        
        Element[] children = ConfigWebFactory.getChildren(parent,"monitor");
        Element monitor=null;
        // Update
        for(int i=0;i<children.length;i++) {
      	    Element el=children[i];
      	    String _name=el.getAttribute("name");
  			if(_name!=null && _name.equalsIgnoreCase(name)) {
  				monitor=el;
  				break;
  			}
      	}
        
        // Insert
      	if(monitor==null) {
      		monitor = doc.createElement("monitor");
      		parent.appendChild(monitor);
      	}
        
      	monitor.setAttribute("class",className);
      	monitor.setAttribute("type",type);
      	monitor.setAttribute("name",name);
      	monitor.setAttribute("log",Caster.toString(logEnabled));
	}
	



	public void updateExecutionLog(String className, Struct args, boolean enabled) {
		Element el=_getRootElement("execution-log");
		el.setAttribute("class",className);
		el.setAttribute("arguments",toStringCSSStyle(args));
		el.setAttribute("enabled",Caster.toString(enabled));
	}
	
	
	
	
	

	public void removeMonitor(String name) throws PageException {
		checkWriteAccess();
		
        Element parent=_getRootElement("monitoring");
        
        
        Element[] children = ConfigWebFactory.getChildren(parent,"monitor");
        // Update
        for(int i=0;i<children.length;i++) {
      	    Element el=children[i];
      	    String _name=el.getAttribute("name");
  			if(_name!=null && _name.equalsIgnoreCase(name)) {
  				parent.removeChild(el);
  			}
      	}
        
	}


	public void updateExtensionInfo(boolean enabled) {
		Element extensions=_getRootElement("extensions");
		extensions.setAttribute("enabled", Caster.toString(enabled));
	}
	

	public void updateExtensionProvider(String strUrl) {
		Element extensions=_getRootElement("extensions");
		Element[] children = ConfigWebFactory.getChildren(extensions,"provider");
      	strUrl=strUrl.trim();
        
      	// Update
		Element el;
		String url;
        for(int i=0;i<children.length;i++) {
      	    el=children[i];
      	    url=el.getAttribute("url");
      	    if(	url!=null && url.trim().equalsIgnoreCase(strUrl)) {
  				//el.setAttribute("cache-timeout",Caster.toString(cacheTimeout));
  				return ;
  			}
      	}
        
     // Insert
      	el = doc.createElement("provider");

      	el.setAttribute("url",strUrl);
      	//el.setAttribute("cache-timeout",Caster.toString(cacheTimeout));
  		
  		XMLUtil.prependChild(extensions,el);
	}
	

	public void removeExtensionProvider(String strUrl) {
		Element parent=_getRootElement("extensions");
		Element[] children = ConfigWebFactory.getChildren(parent,"provider");
		strUrl=strUrl.trim();
		Element child;
		String url;
        for(int i=0;i<children.length;i++) {
      	    child=children[i];
      	    url=child.getAttribute("url");
			if(	url!=null && url.trim().equalsIgnoreCase(strUrl)) {
  				parent.removeChild(child);
  				return ;
  			}
      	}
	}
	

	public void updateExtension(PageContext pc,Extension extension) throws PageException {
		checkWriteAccess();
		
		String uid = createUid(pc,extension.getProvider(),extension.getId());
		
		Element extensions=_getRootElement("extensions");
		Element[] children = ConfigWebFactory.getChildren(extensions,"extension");
      	
        // Update
		Element el;
		String provider,id;
        for(int i=0;i<children.length;i++) {
      	    el=children[i];
      	    provider=el.getAttribute("provider");
      	    id=el.getAttribute("id");
  			if(uid.equalsIgnoreCase(createUid(pc,provider, id))) {
  				setExtensionAttrs(el,extension);
  				return ;
  			}
      	}
        
     // Insert
      	el = doc.createElement("extension");

  		el.setAttribute("provider",extension.getProvider());
  		el.setAttribute("id",extension.getId());
  		setExtensionAttrs(el,extension);
      	extensions.appendChild(el);
	}


	private String createUid(PageContext pc,String provider, String id) throws PageException {
		if(Decision.isUUId(id)) {
			return Hash.invoke(pc.getConfig(),id,null,null, 1);
		}
		return Hash.invoke(pc.getConfig(),provider+id,null,null, 1);
	}


	private void setExtensionAttrs(Element el, Extension extension) {
      	el.setAttribute("version",extension.getVersion());
      	
      	el.setAttribute("config",extension.getStrConfig());
      	//el.setAttribute("config",new ScriptConverter().serialize(extension.getConfig()));
  		
  		el.setAttribute("category",extension.getCategory());
  		el.setAttribute("description",extension.getDescription());
  		el.setAttribute("image",extension.getImage());
  		el.setAttribute("label",extension.getLabel());
  		el.setAttribute("name",extension.getName());

  		el.setAttribute("author",extension.getAuthor());
  		el.setAttribute("type",extension.getType());
  		el.setAttribute("codename",extension.getCodename());
  		el.setAttribute("video",extension.getVideo());
  		el.setAttribute("support",extension.getSupport());
  		el.setAttribute("documentation",extension.getDocumentation());
  		el.setAttribute("forum",extension.getForum());
  		el.setAttribute("mailinglist",extension.getMailinglist());
  		el.setAttribute("network",extension.getNetwork());
  		el.setAttribute("created",Caster.toString(extension.getCreated(),null));


	}
	

	public void resetORMSetting() throws SecurityException {
		boolean hasAccess=ConfigWebUtil.hasAccess(config,SecurityManagerImpl.TYPE_ORM);
        
    	if(!hasAccess)
            throw new SecurityException("no access to update ORM Settings");
        
		
		
		Element orm=_getRootElement("orm");
		orm.getParentNode().removeChild(orm);
	}
	

	public void updateORMSetting(ORMConfiguration oc) throws SecurityException {
		boolean hasAccess=ConfigWebUtil.hasAccess(config,SecurityManagerImpl.TYPE_ORM);
        
		if(!hasAccess)
            throw new SecurityException("no access to update ORM Settings");
        
		
		
		Element orm=_getRootElement("orm");
		orm.setAttribute("autogenmap",Caster.toString(oc.autogenmap(),"true"));
		orm.setAttribute("event-handler",Caster.toString(oc.eventHandler(),""));
		orm.setAttribute("event-handling",Caster.toString(oc.eventHandling(),"false"));
		orm.setAttribute("naming-strategy",Caster.toString(oc.namingStrategy(),""));
		orm.setAttribute("flush-at-request-end",Caster.toString(oc.flushAtRequestEnd(),"true"));
		orm.setAttribute("cache-provider",Caster.toString(oc.getCacheProvider(),""));
		orm.setAttribute("cache-config",Caster.toString(oc.getCacheConfig(),"true"));
		orm.setAttribute("catalog",Caster.toString(oc.getCatalog(),""));
		orm.setAttribute("db-create",ORMConfigurationImpl.dbCreateAsString(oc.getDbCreate()));
		orm.setAttribute("dialect",Caster.toString(oc.getDialect(),""));
		orm.setAttribute("schema",Caster.toString(oc.getSchema(),""));
		orm.setAttribute("log-sql",Caster.toString(oc.logSQL(),"false"));
		orm.setAttribute("save-mapping",Caster.toString(oc.saveMapping(),"false"));
		orm.setAttribute("secondary-cache-enable",Caster.toString(oc.secondaryCacheEnabled(),"false"));
		orm.setAttribute("use-db-for-mapping",Caster.toString(oc.useDBForMapping(),"true"));
		orm.setAttribute("orm-config",Caster.toString(oc.getOrmConfig(),""));
		orm.setAttribute("sql-script",Caster.toString(oc.getSqlScript(),"true"));
		
		if(oc.isDefaultCfcLocation()) {
			orm.removeAttribute("cfc-location");
		}
		else {
			Resource[] locations = oc.getCfcLocations();
			StringBuilder sb=new StringBuilder();
			for(int i=0;i<locations.length;i++) {
				if(i!=0)sb.append(",");
				sb.append(locations[i].getAbsolutePath());
			}
			orm.setAttribute("cfc-location",sb.toString());
		}
		
		
		orm.setAttribute("sql-script",Caster.toString(oc.getSqlScript(),"true"));
		
	}


	public void removeExtension(String provider, String id) throws SecurityException {
		checkWriteAccess();
    	
		Element extensions=_getRootElement("extensions");
		Element[] children = ConfigWebFactory.getChildren(extensions,"extension");
		Element child;
		String _provider, _id;
      	for(int i=0;i<children.length;i++) {
      	    child=children[i];
      		_provider=child.getAttribute("provider");
      	    _id=child.getAttribute("id"); 
  	    	if(_provider!=null && _provider.equalsIgnoreCase(provider) && _id!=null && _id.equalsIgnoreCase(id)) {
	      		extensions.removeChild(child);
  			}
  	    }
	}
	
	public void verifyExtensionProvider(String strUrl) throws PageException {
		HTTPResponse method=null;
		try {
			URL url = HTTPUtil.toURL(strUrl+"?wsdl",true);
			method = HTTPEngine.get(url, null, null, 2000,HTTPEngine.MAX_REDIRECT, null, null, null, null);
		} 
		catch (MalformedURLException e) {
			throw new ApplicationException("url defintion ["+strUrl+"] is invalid");
		} 
		catch (IOException e) {
			throw new ApplicationException("can't invoke ["+strUrl+"]",e.getMessage());
		}
		
		if(method.getStatusCode()!=200){int code=method.getStatusCode();
    	String text=method.getStatusText();
    	String msg=code+" "+text;
    	throw new HTTPException(msg,null,code,text,method.getURL());
		}
		//Object o = 
			CreateObject.doWebService(null, strUrl+"?wsdl");
			
	}


	public void updateTLD(Resource resTld) throws IOException {
		updateLD(config.getTldFile(),resTld);
	}
	public void updateFLD(Resource resFld) throws IOException {
		updateLD(config.getFldFile(),resFld);
	}
	
	private void updateLD(Resource dir,Resource res) throws IOException {
		if(!dir.exists())dir.createDirectory(true);
    	
    	Resource file = dir.getRealResource(res.getName());
    	if(file.length()!=res.length()){
			ResourceUtil.copy(res, file);
		}
	}
	
	static void updateTLD(Config config,InputStream is,String name, boolean closeStream) throws IOException {
		updateLD(config.getTldFile(),is,name,closeStream);
	}
	static void updateFLD(Config config,InputStream is,String name, boolean closeStream) throws IOException {
		updateLD(config.getFldFile(),is,name,closeStream);
	}
	
	private static void updateLD(Resource dir,InputStream is,String name, boolean closeStream) throws IOException {
		if(!dir.exists())dir.createDirectory(true);
    	Resource file = dir.getRealResource(name);
    	IOUtil.copy(is, file.getOutputStream(), closeStream, true);
	}

	public void removeTLD(String name) throws IOException {
		removeLD(config.getTldFile(),name);
	}
	
	public void removeTLDs(String[] names) throws IOException {
		if(ArrayUtil.isEmpty(names)) return;
		Resource file = config.getTldFile();
		for(int i=0;i<names.length;i++){
			removeLD(file,names[i]);
		}
	}

	public void removeFLDs(String[] names) throws IOException {
		if(ArrayUtil.isEmpty(names)) return;
		Resource file = config.getFldFile();
		for(int i=0;i<names.length;i++){
			removeLD(file,names[i]);
		}
	}

	public void removeFLD(String name) throws IOException {
		removeLD(config.getFldFile(),name);
	}
	
	private void removeLD(Resource dir,String name) throws IOException {
		if(dir.isDirectory()){
			Resource[] children = dir.listResources(new MyResourceNameFilter(name));
			for(int i=0;i<children.length;i++){
				children[i].remove(false);
			}
		}
	}

	public void updateJar(Resource resJar) throws IOException {
		updateJar(config, resJar);
	}
	private static void updateJar(Config config, Resource resJar) throws IOException {
		Resource lib = config.getConfigDir().getRealResource("lib");
		if(!lib.exists())lib.mkdir();
    	
		Resource fileLib = lib.getRealResource(resJar.getName());
		
		if(fileLib.length()!=resJar.length()){
			IOUtil.closeEL(config.getClassLoader());
			ResourceUtil.copy(resJar, fileLib);
			ConfigWebFactory.reloadLib((ConfigImpl) config);
		}
	}
	
	static void updateJar(Config config, InputStream is, String name,boolean closeStream) throws IOException {
		Resource lib = config.getConfigDir().getRealResource("lib");
		if(!lib.exists())lib.mkdir();
    	
		Resource fileLib = lib.getRealResource(name);
		
		IOUtil.closeEL(config.getClassLoader());
		IOUtil.copy(is, fileLib.getOutputStream(), closeStream, true);
		ConfigWebFactory.reloadLib((ConfigImpl) config);
	}

	public void updateRemoteClientUsage(String code, String displayname) {
		Struct usage = config.getRemoteClientUsage();
		usage.setEL(code, displayname);
		
		Element extensions=_getRootElement("remote-clients");
		extensions.setAttribute("usage", toStringURLStyle(usage));		
		
	}

	public void updateClusterClass(String classname) throws PageException {
		if(StringUtil.isEmpty(classname,true))
			classname=ClusterNotSupported.class.getName();
		
		
    	Class clazz=null;
		try {
			clazz = ClassUtil.loadClass(config.getClassLoader(),classname);
		} catch (ClassException e) {
			throw Caster.toPageException(e);
		}
		if(!Reflector.isInstaneOf(clazz,Cluster.class) && !Reflector.isInstaneOf(clazz,ClusterRemote.class))
    		throw new ApplicationException("class ["+clazz.getName()+"] does not implement interface ["+Cluster.class.getName()+"] or ["+ClusterRemote.class.getName()+"]");   
		

		Element scope=_getRootElement("scope");
		scope.setAttribute("cluster-class", clazz.getName());	
		ScopeContext.clearClusterScope();
	}
	

	
	public void updateVideoExecuterClass(String classname) throws PageException {
		classname=classname.trim();
		
		if(StringUtil.isEmpty(classname,true))
			classname=VideoExecuterNotSupported.class.getName();
		
		Class clazz=null;
		try {
			clazz = ClassUtil.loadClass(config.getClassLoader(),classname);
		} catch (ClassException e) {
			throw Caster.toPageException(e);
		}
		if(!Reflector.isInstaneOf(clazz,VideoExecuter.class))
    		throw new ApplicationException("class ["+clazz.getName()+"] does not implement interface ["+VideoExecuter.class.getName()+"]");   
		

		Element app=_getRootElement("video");
		app.setAttribute("video-executer-class", clazz.getName());	
	}
	public void updateAdminSyncClass(String classname) throws PageException {
		classname=classname.trim();
		
		if(StringUtil.isEmpty(classname,true))
			classname=AdminSyncNotSupported.class.getName();
		
		Class clazz=null;
		try {
			clazz = ClassUtil.loadClass(config.getClassLoader(),classname);
		} catch (ClassException e) {
			throw Caster.toPageException(e);
		}
		if(!Reflector.isInstaneOf(clazz,AdminSync.class))
    		throw new ApplicationException("class ["+clazz.getName()+"] does not implement interface ["+AdminSync.class.getName()+"]");   
		

		Element app=_getRootElement("application");
		app.setAttribute("admin-sync-class", clazz.getName());	
	}
	
	
	
	public void removeRemoteClientUsage(String code) {
		Struct usage = config.getRemoteClientUsage();
		usage.removeEL(KeyImpl.getInstance(code));
		
		Element extensions=_getRootElement("remote-clients");
		extensions.setAttribute("usage", toStringURLStyle(usage));		
		
	}

	public void removeJar(String strNames) throws IOException {
		removeJar(ListUtil.listToStringArray(strNames, ','));
	}
	public void removeJar(String[] names) throws IOException {
		if(ArrayUtil.isEmpty(names)) return;
		
		
		Resource lib = config.getConfigDir().getRealResource("lib");
		boolean changed=false;
		if(lib.isDirectory()){
			for(int n=0;n<names.length;n++){
				Resource[] children = lib.listResources(new MyResourceNameFilter(names[n].trim()));
				for(int i=0;i<children.length;i++){
					try {
						changed=true;
						IOUtil.closeEL(config.getClassLoader());
						children[i].remove(false);
					} 
					catch (IOException ioe) {
						if(children[i] instanceof File)
							((File)children[i]).deleteOnExit();
						else{
							ConfigWebFactory.reloadLib(this.config);
							throw ioe;
						}
					}
				}
			}
		}
		if(changed){
			ConfigWebFactory.reloadLib(this.config);
			//new ResourceClassLoader(lib.listResources(),config.getClass().getClassLoader());
		}
	}

	class MyResourceNameFilter implements ResourceNameFilter {
		private String name;
		public MyResourceNameFilter(String name){
			this.name=name;
		}
		
		@Override
		public boolean accept(Resource parent, String name) {
			return name.equals(this.name);
		}
	}

	 public void updateSerial(String serial) throws PageException {
		 	
	    	checkWriteAccess();
	        if(!(config instanceof ConfigServer)) {
	            throw new SecurityException("can't change serial number from this context, access is denied");
	        }
	        
	        Element root=doc.getDocumentElement();
	        if(!StringUtil.isEmpty(serial)){
	        	serial=serial.trim();
	        	if(!new SerialNumber(serial).isValid(serial))
	        		throw new SecurityException("serial number is invalid");
	        	root.setAttribute("serial-number",serial);
	        }
	        else{
	        	try{
	        		root.removeAttribute("serial-number");
	        	}
	        	catch(Throwable t){}
	        }
        	try{
        		root.removeAttribute("serial");
        	}
        	catch(Throwable t){}
	    }


	public boolean updateLabel(String hash, String label) {
		// check
        if(StringUtil.isEmpty(hash,true))  return false;
        if(StringUtil.isEmpty(label,true)) return false;
        
		hash=hash.trim(); 
		label=label.trim();
        
        Element labels=_getRootElement("labels");
        
        // Update
        Element[] children = ConfigWebFactory.getChildren(labels,"label");
      	for(int i=0;i<children.length;i++) {
      	    String h=children[i].getAttribute("id");
      	    if(h!=null) {
      	        if(h.equals(hash)) {
		      		Element el=children[i];
		      		if(label.equals(el.getAttribute("name"))) return false;
		      		el.setAttribute("name",label);
		      		return true;
	  			}
      	    }
      	}
      	
      	// Insert
      	Element el=doc.createElement("label");
      	labels.appendChild(el);
      	el.setAttribute("id",hash);
      	el.setAttribute("name",label);
  		
      	return true;
	}
	
	
	public void updateDebugSetting(int maxLogs) throws SecurityException {
		checkWriteAccess();
        boolean hasAccess=ConfigWebUtil.hasAccess(config,SecurityManager.TYPE_DEBUGGING);
        if(!hasAccess)
            throw new SecurityException("no access to change debugging settings");
		
        
        Element debugging=_getRootElement("debugging");
        if(maxLogs==-1)
        	debugging.removeAttribute("max-records-logged");
        else
        	debugging.setAttribute("max-records-logged", Caster.toString(maxLogs));
	}


	public void updateDebugEntry(String type, String iprange,String label,String path,String fullname, Struct custom) throws SecurityException, IOException {
		checkWriteAccess();
        boolean hasAccess=ConfigWebUtil.hasAccess(config,SecurityManager.TYPE_DEBUGGING);
        if(!hasAccess)
            throw new SecurityException("no access to change debugging settings");
		
        // leave this, this method throws a exception when ip range is not valid
        IPRange.getInstance(iprange);
        
		String id=MD5.getDigestAsString(label.trim().toLowerCase());
		type=type.trim();
		iprange=iprange.trim();
		label=label.trim();
		
        Element debugging=_getRootElement("debugging");
        
        // Update
        Element[] children = ConfigWebFactory.getChildren(debugging,"debug-entry");
        Element el=null;
      	for(int i=0;i<children.length;i++) {
      	    String _id=children[i].getAttribute("id");
      	    if(_id!=null) {
      	        if(_id.equals(id)) {
		      		el=children[i];
		      		break;
	  			}
      	    }
      	}
      	
      	// Insert
      	if(el==null) {
      		el=doc.createElement("debug-entry");
          	debugging.appendChild(el);
          	el.setAttribute("id",id);
      	}
      	

  		el.setAttribute("type",type);
  		el.setAttribute("iprange",iprange);
  		el.setAttribute("label",label);
  		el.setAttribute("path",path);
  		el.setAttribute("fullname",fullname);
  		el.setAttribute("custom",toStringURLStyle(custom));
	}




	public void removeDebugEntry(String id) throws SecurityException {
		checkWriteAccess();
        boolean hasAccess=ConfigWebUtil.hasAccess(config,SecurityManager.TYPE_DEBUGGING);
        if(!hasAccess)
            throw new SecurityException("no access to change debugging settings");

    	
        Element debugging=_getRootElement("debugging");
        Element[] children = ConfigWebFactory.getChildren(debugging,"debug-entry");
        String _id;
        if(children.length>0) {
	      	for(int i=0;i<children.length;i++) {
	      	    Element el=children[i];
	      	    _id=el.getAttribute("id");
	  			if(_id!=null && _id.equalsIgnoreCase(id)) {
		      		debugging.removeChild(children[i]);
	  			}
	      	}
        }
	}


	public void updateLoginSettings(boolean captcha, boolean rememberMe, int delay) {

        Element login=_getRootElement("login");
        login.setAttribute("captcha",Caster.toString(captcha));
        login.setAttribute("rememberme",Caster.toString(rememberMe));
        login.setAttribute("delay",Caster.toString(delay));
		
	}
	



	public void updateLogSettings(String name, Level level, String appenderClassName, Struct appenderArgs, String layoutClassName, Struct layoutArgs) throws PageException {
		checkWriteAccess();
		// TODO
    	//boolean hasAccess=ConfigWebUtil.hasAccess(config,SecurityManagerImpl.TYPE_GATEWAY);
        // if(!hasAccess) throw new SecurityException("no access to update gateway entry");
        
        // check parameters
		name=name.trim();
    	if(StringUtil.isEmpty(name))
            throw new ApplicationException("name can't be a empty value");

    	if(StringUtil.isEmpty(appenderClassName))
    		throw new ExpressionException("you must define appender class name");
    	if(StringUtil.isEmpty(layoutClassName))
    		throw new ExpressionException("you must define layout class name");
    	
        try {
        	ClassUtil.loadClass(appenderClassName);
        	ClassUtil.loadClass(layoutClassName);
        	
		}
        catch (ClassException e) {
            throw Caster.toPageException(e);
		}
        
        Element parent=_getRootElement("logging");
        
        // Update
        Element[] children = ConfigWebFactory.getChildren(parent,"logger");
        Element el=null;
      	for(int i=0;i<children.length;i++) {
      	    String n=children[i].getAttribute("name");
      	    if(name.equalsIgnoreCase(n)) {
      	    	el=children[i];
      	    	break;
  			}
      	  
      	}
      	// Insert
      	if(el==null) {
	      	el=doc.createElement("logger");
	      	parent.appendChild(el);
	      	el.setAttribute("name",name);
      	}
      	
      	// appender
      	if(appenderClassName.equals(ConsoleAppender.class.getName())) appenderClassName="console";
      	if(appenderClassName.equals(RollingResourceAppender.class.getName())) appenderClassName="resource";
      	// layout
      	if(layoutClassName.equals(PatternLayout.class.getName())) layoutClassName="pattern";
      	if(layoutClassName.equals(ClassicLayout.class.getName())) layoutClassName="classic";
      	if(layoutClassName.equals(HTMLLayout.class.getName())) layoutClassName="html";
      	if(layoutClassName.equals(XMLLayout.class.getName())) layoutClassName="xml";

      	el.setAttribute("level",level.toString());
  		el.setAttribute("appender",appenderClassName);
      	el.setAttribute("appender-arguments",toStringCSSStyle(appenderArgs));
	    el.setAttribute("layout",layoutClassName);
	    el.setAttribute("layout-arguments",toStringCSSStyle(layoutArgs));
	}


	public void updateCompilerSettings(Boolean dotNotationUpperCase, Boolean suppressWSBeforeArg, Boolean nullSupport) throws PageException {
		
		Element element = _getRootElement("compiler");
		
    	checkWriteAccess();
    	if(dotNotationUpperCase==null){
			if(element.hasAttribute("dot-notation-upper-case"))
				element.removeAttribute("dot-notation-upper-case");
		}
    	else {
    		element.setAttribute("dot-notation-upper-case", Caster.toString(dotNotationUpperCase));
    	}
    	

		// remove old settings
		if(element.hasAttribute("supress-ws-before-arg"))
			element.removeAttribute("supress-ws-before-arg");
		
    	if(suppressWSBeforeArg==null){
			if(element.hasAttribute("suppress-ws-before-arg"))
				element.removeAttribute("suppress-ws-before-arg");
		}
    	else {
    		element.setAttribute("suppress-ws-before-arg", Caster.toString(suppressWSBeforeArg));
    	}
    	
    	// full null support
    	if(nullSupport==null){
			if(element.hasAttribute("full-null-support"))
				element.removeAttribute("full-null-support");
		}
    	else {
    		element.setAttribute("full-null-support", Caster.toString(nullSupport));
    	}
    	
    	
    	
	}
	
	/*private void updatePlugin(Resource src) throws PageException, IOException {
        Resource srcDir = ResourceUtil.toResourceExisting(config, "zip://"+src.getAbsolutePath());
        if(!doAccept(srcDir))
        	throw new ApplicationException("plugin ["+src+"] is invalid, missing one of the following files [Action.cfc,language.xml] in root, existing files are ["+lucee.runtime.type.util.ListUtil.arrayToList(srcDir.list(), ", ")+"]");
        
        String name=ResourceUtil.getName(src.getName());
        
        Resource dir = config.getConfigDir().getRealResource("context/admin/plugin");
        Resource trgDir = dir.getRealResource(name);
        if(trgDir.exists()){
        	trgDir.remove(true);
        }
        
        ResourceUtil.copyRecursive(srcDir, trgDir);    
        store();
    }
	public static boolean doAccept(Resource res) {
		return res.isDirectory() && res.getRealResource("/Action.cfc").isFile() && res.getRealResource("/language.xml").isFile();
    }*/

	
	static Resource[] updateContext(ConfigImpl config,InputStream is,String relpath, boolean closeStream) throws PageException, IOException, SAXException {
    	//ConfigWebAdmin admin = new ConfigWebAdmin(config, null);
    	List<Resource> filesDeployed=new ArrayList<Resource>();
    	ConfigWebAdmin._updateContext(config, is, relpath, closeStream, filesDeployed);
    	return filesDeployed.toArray(new Resource[filesDeployed.size()]);
    }

	private static void _updateContext(Config config,InputStream is,String relpath, boolean closeStream,List<Resource> filesDeployed) throws PageException, IOException, SAXException {
    	if(config instanceof ConfigServer) {
    		ConfigWeb[] webs = ((ConfigServer)config).getConfigWebs();
    		if(webs.length==0) return;
    		if(webs.length==1) {
    			_updateContext(webs[0], is,relpath,closeStream,filesDeployed);
    			return;
    		}
        	try{
	    		byte[] barr = IOUtil.toBytes(is);
	    		for(int i=0;i<webs.length;i++){
	    			_updateContext(webs[i], new ByteArrayInputStream(barr),relpath,true,filesDeployed);
	    		}
        	}
        	finally {
        		if(closeStream)IOUtil.closeEL(is);
        	}
    		return ;
    	}
		
    	// ConfigWeb
    	Resource trg = config.getConfigDir().getRealResource("context").getRealResource(relpath);
        if(trg.exists()) trg.remove(true);
        Resource p = trg.getParentResource();
        if(!p.isDirectory()) p.createDirectory(true); 
        IOUtil.copy(is, trg.getOutputStream(false), closeStream,true);
        filesDeployed.add(trg);
        _store((ConfigImpl)config);
    }
	public boolean removeContext(Config config, boolean store,String... relpathes) throws PageException, IOException, SAXException {
		if(ArrayUtil.isEmpty(relpathes)) return false;
		boolean force=false;
		for(int i=0;i<relpathes.length;i++){
			if(_removeContext(config, relpathes[i],store))
				force=true;
		}
		return force;
	}
	
	private boolean _removeContext(Config config,String relpath, boolean _store) throws PageException, IOException, SAXException {
    	
		if(config instanceof ConfigServer) {
			ConfigServer cs = ((ConfigServer)config);
    		
			// remove files from deploy folder
			Resource deploy = cs.getConfigDir().getRealResource("web-context-deployment");
    		Resource trg = deploy.getRealResource(relpath);
    		
    		if(trg.exists()) {
    			trg.remove(true);
    			ResourceUtil.removeEmptyFolders(deploy,null);
    		}
    		
			// remove files from lucee web context
			boolean store=false;
			ConfigWeb[] webs = cs.getConfigWebs();
    		for(int i=0;i<webs.length;i++){
	    		if(_removeContext(webs[i], relpath,_store)) {
	    			store=true;
	    		}
	    	}
    		return store;
    	}
		
    	// ConfigWeb
		Resource context = config.getConfigDir().getRealResource("context");
    	Resource trg = context.getRealResource(relpath);
    	if(trg.exists()) {
        	trg.remove(true);
        	if(_store) ConfigWebAdmin._store((ConfigImpl) config);
        	ResourceUtil.removeEmptyFolders(context,null);
        	return true;
        }
        return false;
    }

	static Resource[] updateApplication(ConfigImpl config,InputStream is,String relpath, boolean closeStream) throws PageException, IOException, SAXException {
    	ConfigWebAdmin admin = new ConfigWebAdmin(config, null);
    	List<Resource> filesDeployed=new ArrayList<Resource>();
    	admin._updateApplication(config, is, relpath, closeStream, filesDeployed);
    	return filesDeployed.toArray(new Resource[filesDeployed.size()]);
    }

	private void _updateApplication(Config config,InputStream is,String relpath, boolean closeStream,List<Resource> filesDeployed) throws PageException, IOException, SAXException {
    	if(config instanceof ConfigServer) {
    		ConfigWeb[] webs = ((ConfigServer)config).getConfigWebs();
    		if(webs.length==0) return;
    		if(webs.length==1) {
    			_updateApplication(webs[0], is,relpath,closeStream,filesDeployed);
    			return;
    		}
        	try{
	    		byte[] barr = IOUtil.toBytes(is);
	    		for(int i=0;i<webs.length;i++){
	    			_updateApplication(webs[i], new ByteArrayInputStream(barr),relpath,true,filesDeployed);
	    		}
        	}
        	finally {
        		if(closeStream)IOUtil.closeEL(is);
        	}
    		return ;
    	}
		
    	// ConfigWeb
    	
    	
    	Resource trg = config.getRootDirectory().getRealResource(relpath);
    	if(trg.exists()) trg.remove(true);
        Resource p = trg.getParentResource();
        if(!p.isDirectory()) p.createDirectory(true); 
        IOUtil.copy(is, trg.getOutputStream(false), closeStream,true);
        filesDeployed.add(trg);
        //_store((ConfigImpl)config);
    }

	private void removeApplications(Config config,String[] relpathes) throws PageException, IOException, SAXException {
		if(ArrayUtil.isEmpty(relpathes)) return;
		for(int i=0;i<relpathes.length;i++){
			removeApplication(config, relpathes[i]);
		}
	}
	
	private void removeApplication(Config config,String relpath) throws PageException, IOException, SAXException {
    	if(config instanceof ConfigServer) {
    		ConfigWeb[] webs = ((ConfigServer)config).getConfigWebs();
			for(int i=0;i<webs.length;i++){
				removeApplication(webs[i], relpath);
    		}
        	
    		return ;
    	}
		
    	// ConfigWeb
    	Resource trg = config.getRootDirectory().getRealResource(relpath);
    	if(trg.exists()) trg.remove(true);
    }
	
	public static void removeRHExtension(ConfigImpl config,String extensionID) throws SAXException, IOException, PageException {
		ConfigWebAdmin admin = new ConfigWebAdmin(config, null);
		boolean storeChildren = admin._removeExtension(config, extensionID);
		admin._store();
		
		if(storeChildren && config instanceof ConfigServer) {
			ConfigServer cs = (ConfigServer)config;
			ConfigWeb[] webs = cs.getConfigWebs();
			for(int i=0;i<webs.length;i++) {
				admin._store((ConfigImpl)webs[i]);
			}
		}
	}


	public boolean _removeExtension(ConfigImpl config,String extensionID) throws IOException, PageException, SAXException {
		if(!Decision.isUUId(extensionID)) throw new IOException("id ["+extensionID+"] is invalid, it has to be a UUID"); 
		
		Element extensions=_getRootElement("extensions");
		Element[] children = ConfigWebFactory.getChildren(extensions,"rhextension");// LuceeHandledExtensions
      	
        // Update
		Element el;
		String id;
		String[] arr;
		boolean storeChildren=false;
        for(int i=0;i<children.length;i++) {
      	    el=children[i];
      	    id=el.getAttribute("id");
  			if(extensionID.equalsIgnoreCase(id)) {
  				
  				// jars
  				arr=_removeExtensionCheckOtherUsage(children,el,"jars");
  				removeJar(arr);
  				// flds
  				arr=_removeExtensionCheckOtherUsage(children,el,"flds");
  				removeFLDs(arr);
  				// tlds
  				arr=_removeExtensionCheckOtherUsage(children,el,"tlds");
  				removeTLDs(arr);
  				// contexts
  				arr=_removeExtensionCheckOtherUsage(children,el,"contexts");
  				storeChildren=removeContext(config,false, arr);
  				// applications
  				arr=_removeExtensionCheckOtherUsage(children,el,"applications");
  				removeApplications(config, arr);
  				
  				
  				
  				extensions.removeChild(el);
  				return storeChildren;
  			}
      	}
  		return false;
	}
	
	private String[] _removeExtensionCheckOtherUsage(Element[] children, Element curr,String type) {
		String currVal=curr.getAttribute(type);
		if(StringUtil.isEmpty(currVal)) return null;
		
		String otherVal;
		Element other;
		Set<String> currSet = ListUtil.toSet(ListUtil.trimItems(ListUtil.listToStringArray(currVal, ',')));
		String[] otherArr;
		for(int i=0;i<children.length;i++) {
			other=children[i];
			if(other==curr) continue;
			otherVal=other.getAttribute(type);
			if(StringUtil.isEmpty(otherVal)) continue;
			otherArr=ListUtil.trimItems(ListUtil.listToStringArray(otherVal, ','));
			for(int y=0;y<otherArr.length;y++) {
				currSet.remove(otherArr[y]);
			}
		}
		return currSet.toArray(new String[currSet.size()]);
	}


	public static void updateRHExtension(ConfigImpl config,RHExtension rhExtension) throws SAXException, IOException, PageException {
		ConfigWebAdmin admin = new ConfigWebAdmin(config, null);
		admin._updateExtension(config, rhExtension);
		admin._store();
	}


	public void _updateExtension(ConfigImpl config,RHExtension ext) throws IOException {
		if(!Decision.isUUId(ext.getId())) throw new IOException("id ["+ext.getId()+"] is invalid, it has to be a UUID"); 
		
		Element extensions=_getRootElement("extensions");
		Element[] children = ConfigWebFactory.getChildren(extensions,"rhextension");// LuceeHandledExtensions
      	
        // Update
		Element el;
		String provider,id;
        for(int i=0;i<children.length;i++) {
      	    el=children[i];
      	    provider=el.getAttribute("provider");
      	    id=el.getAttribute("id");
  			if(ext.getId().equalsIgnoreCase(id)) {
  				setExtensionAttrs(el,ext);
  				return ;
  			}
      	}
        
     // Insert
      	el = doc.createElement("rhextension");
      	setExtensionAttrs(el,ext);
  		extensions.appendChild(el);
    	
	}


	private void setExtensionAttrs(Element el, RHExtension ext) {
		setAttr(el,"id", ext.getId());
		setAttr(el,"name", ext.getName());
		setAttr(el,"version", ext.getVersion());
		setAttr(el,"jars",ListUtil.arrayToList(ext.getJars(), ","));
		setAttr(el,"flds",ListUtil.arrayToList(ext.getFlds(), ","));
		setAttr(el,"tlds",ListUtil.arrayToList(ext.getTlds(), ","));
		setAttr(el,"contexts",ListUtil.arrayToList(ext.getContexts(), ","));
		setAttr(el,"applications",ListUtil.arrayToList(ext.getApplications(), ","));	
	}


	private void setAttr(Element el, String name, String value) {
		if(value==null) value="";
		el.setAttribute(name, value);
	}


	public void updateAuthKey(String key) throws PageException {
		checkWriteAccess();
		key=key.trim();
		
		// merge new key and existing
		ConfigServerImpl cs=(ConfigServerImpl) config;
		String[] keys = cs.getAuthenticationKeys();
		Set<String> set=new HashSet<String>();
		for(int i=0;i<keys.length;i++){
			set.add(keys[i]);
		}
		set.add(key);
		
		
		Element root=doc.getDocumentElement();
        root.setAttribute("auth-keys",authKeysAsList(set));
		
		
	}

	public void removeAuthKeys(String key) throws PageException {
		checkWriteAccess();
		key=key.trim();
		
		// remove key
		ConfigServerImpl cs=(ConfigServerImpl) config;
		String[] keys = cs.getAuthenticationKeys();
		Set<String> set=new HashSet<String>();
		for(int i=0;i<keys.length;i++){
			if(!key.equals(keys[i]))set.add(keys[i]);
		}

		Element root=doc.getDocumentElement();
        root.setAttribute("auth-keys",authKeysAsList(set));
	}

	public void updateAPIKey(String key) throws SecurityException, ApplicationException {
		checkWriteAccess();
		key=key.trim();
		if(!Decision.isGUId(key))
			throw new ApplicationException("passed API Key ["+key+"] is not valid");
		Element root=doc.getDocumentElement();
        root.setAttribute("api-key",key);
		
	}
	
	public void removeAPIKey() throws PageException {
		checkWriteAccess();
		Element root=doc.getDocumentElement();
        if(root.hasAttribute("api-key"))
        	root.removeAttribute("api-key");
	}

	private String authKeysAsList(Set<String> set) throws PageException {
		StringBuilder sb=new StringBuilder();
		Iterator<String> it = set.iterator();
		String key;
		while(it.hasNext()){
			key=it.next().trim();
			if(sb.length()>0)sb.append(',');
			try {
				sb.append(URLEncoder.encode(key, "UTF-8"));
			}
			catch (UnsupportedEncodingException e) {
				throw Caster.toPageException(e);
			}
		}
		return sb.toString();
	}
}