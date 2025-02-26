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

import java.io.File;
import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import lucee.commons.collection.LinkedHashMapMaxSize;
import lucee.commons.collection.MapFactory;
import lucee.commons.digest.Hash;
import lucee.commons.io.SystemUtil;
import lucee.commons.io.res.Resource;
import lucee.commons.io.res.ResourcesImpl;
import lucee.commons.lang.ClassUtil;
import lucee.commons.lang.PCLCollection;
import lucee.commons.lang.StringUtil;
import lucee.commons.lang.SystemOut;
import lucee.loader.engine.CFMLEngine;
import lucee.loader.engine.CFMLEngineFactory;
import lucee.loader.util.ExtensionFilter;
import lucee.runtime.CFMLFactory;
import lucee.runtime.CFMLFactoryImpl;
import lucee.runtime.Mapping;
import lucee.runtime.MappingImpl;
import lucee.runtime.engine.CFMLEngineImpl;
import lucee.runtime.engine.ThreadQueue;
import lucee.runtime.exp.ApplicationException;
import lucee.runtime.exp.ExpressionException;
import lucee.runtime.exp.PageException;
import lucee.runtime.monitor.ActionMonitorCollector;
import lucee.runtime.monitor.IntervallMonitor;
import lucee.runtime.monitor.RequestMonitor;
import lucee.runtime.net.http.ReqRspUtil;
import lucee.runtime.op.Caster;
import lucee.runtime.reflection.Reflector;
import lucee.runtime.security.SecurityManager;
import lucee.runtime.security.SecurityManagerImpl;
import lucee.runtime.type.scope.Cluster;
import lucee.runtime.type.scope.ClusterRemote;
import lucee.runtime.type.scope.ClusterWrap;
import lucee.runtime.type.util.ArrayUtil;

/**
 * config server impl
 */
public final class ConfigServerImpl extends ConfigImpl implements ConfigServer {
	
	private static final long FIVE_SECONDS = 5000;
    
	private final CFMLEngineImpl engine;
    private Map<String,CFMLFactory> initContextes;
    //private Map contextes;
    private SecurityManager defaultSecurityManager;
    private Map<String,SecurityManager> managers=MapFactory.<String,SecurityManager>getConcurrentMap();
    Password defaultPassword;
    private Resource rootDir;
    private URL updateLocation;
    private String updateType="";
	private ConfigListener configListener;
	private Map<String, String> labels;
	private RequestMonitor[] requestMonitors;
	private IntervallMonitor[] intervallMonitors;
	private ActionMonitorCollector actionMonitorCollector;
	
	private boolean monitoringEnabled=false;
	private int delay=1;
	private boolean captcha=false;
	private boolean rememberMe=true;
	//private static ConfigServerImpl instance;

	private String[] authKeys;
	private String idPro;
	
	private LinkedHashMapMaxSize<Long,String> previousNonces=new LinkedHashMapMaxSize<Long,String>(100);
	
	private int permGenCleanUpThreshold=60;
	 
	/**
     * @param engine 
     * @param initContextes
     * @param contextes
     * @param configDir
     * @param configFile
     */
    protected ConfigServerImpl(CFMLEngineImpl engine,Map<String,CFMLFactory> initContextes, Map<String,CFMLFactory> contextes, Resource configDir, Resource configFile) {
    	super(null,configDir, configFile);
    	this.engine=engine;
    	engine.setConfigServerImpl(this);
    	this.initContextes=initContextes;
        //this.contextes=contextes;
        this.rootDir=configDir;
        //instance=this;
    }
	
    /**
	 * @return the configListener
	 */
	public ConfigListener getConfigListener() {
		return configListener;
	}

	/**
	 * @param configListener the configListener to set
	 */
	public void setConfigListener(ConfigListener configListener) {
		this.configListener = configListener;
	}

    @Override
    public ConfigServer getConfigServer(String password) {
        return this;
    }

    @Override
    public ConfigWeb[] getConfigWebs() {
    
        Iterator<String> it = initContextes.keySet().iterator();
        ConfigWeb[] webs=new ConfigWeb[initContextes.size()];
        int index=0;        
        while(it.hasNext()) {
            webs[index++]=((CFMLFactoryImpl)initContextes.get(it.next())).getConfig();
        }
        return webs;
    }
    
    @Override
    public ConfigWeb getConfigWeb(String relpath) {
        return getConfigWebImpl(relpath);
    }
    
    /**
     * returns CongigWeb Implementtion
     * @param relpath
     * @return ConfigWebImpl
     */
    protected ConfigWebImpl getConfigWebImpl(String relpath) {
    	Iterator<String> it = initContextes.keySet().iterator();
        while(it.hasNext()) {
            ConfigWebImpl cw=((CFMLFactoryImpl)initContextes.get(it.next())).getConfigWebImpl();
            if(ReqRspUtil.getRootPath(cw.getServletContext()).equals(relpath))
                return cw;
        }
        return null;
    }
    
    public ConfigWebImpl getConfigWebById(String id) {
        Iterator<String> it = initContextes.keySet().iterator();
          
        while(it.hasNext()) {
            ConfigWebImpl cw=((CFMLFactoryImpl)initContextes.get(it.next())).getConfigWebImpl();
            if(cw.getId().equals(id))
                return cw;
        }
        return null;
    }
    
    public String getIdPro() {
    	if(idPro==null){
    		idPro = getId(getSecurityKey(),getSecurityToken(),true,null);
    	}
    	return idPro;
    }
    
    /**
     * @return JspFactoryImpl array
     */
    public CFMLFactoryImpl[] getJSPFactories() {
        Iterator<String> it = initContextes.keySet().iterator();
        CFMLFactoryImpl[] factories=new CFMLFactoryImpl[initContextes.size()];
        int index=0;        
        while(it.hasNext()) {
            factories[index++]=(CFMLFactoryImpl)initContextes.get(it.next());
        }
        return factories;
    }
    @Override
    public Map<String,CFMLFactory> getJSPFactoriesAsMap() {
        return initContextes;
    }

    @Override
    public SecurityManager getSecurityManager(String id) {
        Object o=managers.get(id);
        if(o!=null) return (SecurityManager) o;
        if(defaultSecurityManager==null) {
        	defaultSecurityManager = SecurityManagerImpl.getOpenSecurityManager();
        }
        return defaultSecurityManager.cloneSecurityManager();
    }
    
    @Override
    public boolean hasIndividualSecurityManager(String id) {
        return managers.containsKey(id);
    }

    /**
     * @param defaultSecurityManager
     */
    protected void setDefaultSecurityManager(SecurityManager defaultSecurityManager) {
        this.defaultSecurityManager=defaultSecurityManager;
    }

    /**
     * @param id
     * @param securityManager
     */
    protected void setSecurityManager(String id, SecurityManager securityManager) {
        managers.put(id,securityManager);
    }

    /**
     * @param id
     */
    protected void removeSecurityManager(String id) {
        managers.remove(id);
    }
    
    @Override
    public SecurityManager getDefaultSecurityManager() {
        return defaultSecurityManager;
    }
    /**
     * @return Returns the defaultPassword.
     */
    protected Password getDefaultPassword() {
        return defaultPassword;
    }
    
    
    /**
     * @param defaultPassword The defaultPassword to set.
     */
    protected void setDefaultPassword(Password defaultPassword) {
        this.defaultPassword = defaultPassword;
    }

    @Override
    public CFMLEngine getCFMLEngine() {
        return engine;
    }


    /**
     * @return Returns the rootDir.
     */
    public Resource getRootDirectory() {
        return rootDir;
    }

    @Override
    public String getUpdateType() {
        return updateType;
    }

    @Override
    public void setUpdateType(String updateType) {
        if(!StringUtil.isEmpty(updateType))
            this.updateType = updateType;
    }

    @Override
    public URL getUpdateLocation() {
        return updateLocation;
    }

    @Override
    public void setUpdateLocation(URL updateLocation) {
        this.updateLocation = updateLocation;
    }

    @Override
    public void setUpdateLocation(String strUpdateLocation) throws MalformedURLException {
        setUpdateLocation(new URL(strUpdateLocation));
    }

    @Override
    public void setUpdateLocation(String strUpdateLocation, URL defaultValue) {
        try {
            setUpdateLocation(strUpdateLocation);
        } catch (MalformedURLException e) {
            setUpdateLocation(defaultValue);
        }
    }

    @Override
    public SecurityManager getSecurityManager() {
        SecurityManagerImpl sm = (SecurityManagerImpl) getDefaultSecurityManager();//.cloneSecurityManager();
        //sm.setAccess(SecurityManager.TYPE_ACCESS_READ,SecurityManager.ACCESS_PROTECTED);
        //sm.setAccess(SecurityManager.TYPE_ACCESS_WRITE,SecurityManager.ACCESS_PROTECTED);
        return sm;
    }

	public void setLabels(Map<String, String> labels) {
		this.labels=labels;
	}
	public Map<String, String> getLabels() {
		if(labels==null) labels=new HashMap<String, String>();
		return labels;
	}

	
	private ThreadQueue threadQueue;
	public ThreadQueue setThreadQueue(ThreadQueue threadQueue) {
		return this.threadQueue=threadQueue;
	}
	
	public ThreadQueue getThreadQueue() {
		return threadQueue;
	}
	
	public RequestMonitor[] getRequestMonitors() {
		return requestMonitors;
	}
	
	public RequestMonitor getRequestMonitor(String name) throws ApplicationException {
		if(requestMonitors!=null)for(int i=0;i<requestMonitors.length;i++){
			if(requestMonitors[i].getName().equalsIgnoreCase(name))
				return requestMonitors[i];
		}
		throw new ApplicationException("there is no request monitor registered with name ["+name+"]");
	}

	protected void setRequestMonitors(RequestMonitor[] monitors) {
		this.requestMonitors=monitors;;
	}
	public IntervallMonitor[] getIntervallMonitors() {
		return intervallMonitors;
	}

	public IntervallMonitor getIntervallMonitor(String name) throws ApplicationException {
		if(intervallMonitors!=null)for(int i=0;i<intervallMonitors.length;i++){
			if(intervallMonitors[i].getName().equalsIgnoreCase(name))
				return intervallMonitors[i];
		}
		throw new ApplicationException("there is no intervall monitor registered with name ["+name+"]");
	}

	protected void setIntervallMonitors(IntervallMonitor[] monitors) {
		this.intervallMonitors=monitors;;
	}
	

	public void setActionMonitorCollector(ActionMonitorCollector actionMonitorCollector) {
		this.actionMonitorCollector=actionMonitorCollector;
	}
	
	public ActionMonitorCollector getActionMonitorCollector() {
		return actionMonitorCollector;
	}
	
	public Object getActionMonitor(String name) { // FUTURE return ActionMonitor
		return actionMonitorCollector==null?null:actionMonitorCollector.getActionMonitor(name);
	}

	@Override
	public boolean isMonitoringEnabled() {
		return monitoringEnabled;
	}

	protected void setMonitoringEnabled(boolean monitoringEnabled) {
		this.monitoringEnabled=monitoringEnabled;;
	}


	protected void setLoginDelay(int delay) {
		this.delay=delay;
	}

	protected void setLoginCaptcha(boolean captcha) {
		this.captcha=captcha;
	}
	protected void setRememberMe(boolean rememberMe) {
		this.rememberMe=rememberMe;
	}

	
	
	@Override
	public int getLoginDelay() {
		return delay;
	}

	@Override
	public boolean getLoginCaptcha() {
		return captcha;
	}

	@Override
	public boolean getRememberMe() {
		return rememberMe;
	}

    public void reset() {
    	super.reset();
    	getThreadQueue().clear();
    }
    
    @Override
	public Resource getSecurityDirectory(){
    	Resource cacerts=null;
    	// javax.net.ssl.trustStore
    	String trustStore = SystemUtil.getPropertyEL("javax.net.ssl.trustStore");
    	if(trustStore!=null){
    		cacerts = ResourcesImpl.getFileResourceProvider().getResource(trustStore);
    	}
    	
    	// security/cacerts
    	if(cacerts==null || !cacerts.exists()) {
    		cacerts = getConfigDir().getRealResource("security/cacerts");
    		if(!cacerts.exists())cacerts.mkdirs();
    	}
    	return cacerts;
	}
    
    @Override
	public void checkPermGenSpace(boolean check) {
    	int promille=SystemUtil.getFreePermGenSpacePromille();
    	
    	long kbFreePermSpace=SystemUtil.getFreePermGenSpaceSize()/1024;
    	int percentageAvailable = SystemUtil.getPermGenFreeSpaceAsAPercentageOfAvailable();
    	
    	
    	// Pen Gen Space info not available indicated by a return of -1
    	if(check && kbFreePermSpace < 0) {
    		if(countLoadedPages() > 2000)
    		shrink();
    	}
    	else if (check && percentageAvailable < permGenCleanUpThreshold) {
    		shrink();
    		if (permGenCleanUpThreshold >= 5) {
    			//adjust the threshold allowed down so the amount of permgen can slowly grow to its allocated space up to 100%
    			setPermGenCleanUpThreshold(permGenCleanUpThreshold - 5);
    		}
    	}
    	else if(check && kbFreePermSpace < 2048) {
    		SystemOut.printDate(getErrWriter()," Free Perm Gen Space is less than 2Mb (free:"+((SystemUtil.getFreePermGenSpaceSize()/1024))+"kb), shrinking all template classloaders");
    		// first request a GC and then check if it helps
    		System.gc();
    		if((SystemUtil.getFreePermGenSpaceSize()/1024) < 2048) {
    			 shrink();
    		}
    	}
	}
    
    private void shrink() {
    	ConfigWeb[] webs = getConfigWebs();
		int count=0;
		for(int i=0;i<webs.length;i++){
			count+=shrink((ConfigWebImpl) webs[i],false);
		}
		if(count==0) {
			for(int i=0;i<webs.length;i++){
				shrink((ConfigWebImpl) webs[i],true);
			}
		}
	}

	private static int shrink(ConfigWebImpl config, boolean force) {
		int count=0;
		count+=shrink(config.getMappings(),force);
		count+=shrink(config.getCustomTagMappings(),force);
		count+=shrink(config.getComponentMappings(),force);
		count+=shrink(config.getFunctionMapping(),force);
		count+=shrink(config.getServerFunctionMapping(),force);
		count+=shrink(config.getTagMapping(),force);
		count+=shrink(config.getServerTagMapping(),force);
		//count+=shrink(config.getServerTagMapping(),force);
		return count;
	}

	private static int shrink(Mapping[] mappings, boolean force) {
		int count=0;
		for(int i=0;i<mappings.length;i++){
			count+=shrink(mappings[i],force);
		}
		return count;
	}

	private static int shrink(Mapping mapping, boolean force) {
		try {
			PCLCollection pcl = ((MappingImpl)mapping).getPCLCollection();
			if(pcl!=null)return pcl.shrink(force);
		} 
		catch (Throwable t) {
			t.printStackTrace();
		}
		return 0;
	}
	
	public int getPermGenCleanUpThreshold() {
		return permGenCleanUpThreshold;
	}

	public void setPermGenCleanUpThreshold(int permGenCleanUpThreshold) {
		this.permGenCleanUpThreshold = permGenCleanUpThreshold;
	}

	
	 public long countLoadedPages() {
		 long count=0;
		 ConfigWeb[] webs = getConfigWebs();
			for(int i=0;i<webs.length;i++){
	    	count+=_count((ConfigWebImpl) webs[i]);
		}	
		return count;
	 }
	 private static long _count(ConfigWebImpl config) {
		 long count=0;
		count+=_count(config.getMappings());
		count+=_count(config.getCustomTagMappings());
		count+=_count(config.getComponentMappings());
		count+=_count(config.getFunctionMapping());
		count+=_count(config.getServerFunctionMapping());
		count+=_count(config.getTagMapping());
		count+=_count(config.getServerTagMapping());
		//count+=_count(((ConfigWebImpl)config).getServerTagMapping());
		return count;
	}

	 private static long _count(Mapping[] mappings) {
		 long count=0;
		for(int i=0;i<mappings.length;i++){
			count+=_count(mappings[i]);
		}
		return count;
	}

	private static long _count(Mapping mapping) {
		PCLCollection pcl = ((MappingImpl)mapping).getPCLCollection();
		return pcl==null?0:pcl.count();
	}

	@Override
	public Cluster createClusterScope() throws PageException {
		Cluster cluster=null;
		try {
    		if(Reflector.isInstaneOf(getClusterClass(), Cluster.class)){
    			cluster=(Cluster) ClassUtil.loadInstance(
    					getClusterClass(),
						ArrayUtil.OBJECT_EMPTY
						);
    			cluster.init(this);
    		}
    		else if(Reflector.isInstaneOf(getClusterClass(), ClusterRemote.class)){
    			ClusterRemote cb=(ClusterRemote) ClassUtil.loadInstance(
    					getClusterClass(),
						ArrayUtil.OBJECT_EMPTY
						);
	    		
    			cluster=new ClusterWrap(this,cb);
	    		//cluster.init(cs);
    		}
		} 
    	catch (Exception e) {
			throw Caster.toPageException(e);
		}
    	return cluster;
	}

	@Override
	public boolean hasServerPassword() {
		return hasPassword();
	}

	public String[] getInstalledPatches() throws PageException {
		CFMLEngineFactory factory = getCFMLEngine().getCFMLEngineFactory();
    	
		try{
			return factory.getInstalledPatches();
		}
		catch(Throwable t){
			try {
				return getInstalledPatchesOld(factory);
			} catch (Exception e1) {
				throw Caster.toPageException(e1);
			}
		}
	}
	
	private String[] getInstalledPatchesOld(CFMLEngineFactory factory) throws IOException { 
		File patchDir = new File(factory.getResourceRoot(),"patches");
        if(!patchDir.exists())patchDir.mkdirs();
        
		File[] patches=patchDir.listFiles(new ExtensionFilter(new String[]{"."+getCoreExtension()}));
        
        List<String> list=new ArrayList<String>();
        String name;
        int extLen=getCoreExtension().length()+1;
        for(int i=0;i<patches.length;i++) {
        	name=patches[i].getName();
        	name=name.substring(0, name.length()-extLen);
        	 list.add(name);
        }
        String[] arr = list.toArray(new String[list.size()]);
    	Arrays.sort(arr);
        return arr;
	}

	
	private String getCoreExtension()  {
    	return "lco";
	}

	@Override
	public boolean allowRequestTimeout() {
		return engine.allowRequestTimeout();
	}
	

	private boolean fullNullSupport=false;
	protected void setFullNullSupport(boolean fullNullSupport) {
		this.fullNullSupport=fullNullSupport;
	}

	public boolean getFullNullSupport() {
		return fullNullSupport;
	}

	public String[] getAuthenticationKeys() {
		return authKeys==null?new String[0]:authKeys;
	}

	protected void setAuthenticationKeys(String[] authKeys) {
		this.authKeys = authKeys;
	}
	
	public ConfigServer getConfigServer(String key,String nonce) {
        return this;
    }

	public void checkAccess(String password) throws ExpressionException {
		if(!hasPassword())
            throw new ExpressionException("Cannot access, no password is defined");
        if(!passwordEqual(password))
            throw new ExpressionException("No access, password is invalid");
	}

	public void checkAccess(String key, long timeNonce) throws PageException {
		
		if(previousNonces.containsKey(timeNonce)) {
			long now = System.currentTimeMillis();
			long diff=timeNonce>now?timeNonce-now:now-timeNonce;
			if(diff>10)
				throw new ApplicationException("nonce was already used, same nonce can only be used once");
			
			
		}
    	long now = System.currentTimeMillis()+getTimeServerOffset();
    	if(timeNonce>(now+FIVE_SECONDS) || timeNonce<(now-FIVE_SECONDS))
    		throw new ApplicationException("nonce is outdated (timserver offset:"+getTimeServerOffset()+")");
    	previousNonces.put(timeNonce,"");
    	
    	String[] keys=getAuthenticationKeys();
    	// check if one of the keys matching
    	String hash;
    	for(int i=0;i<keys.length;i++){
    		try {
    			hash=Hash.hash(keys[i], Caster.toString(timeNonce), Hash.ALGORITHM_SHA_256, Hash.ENCODING_HEX);
    			if(hash.equals(key)) return;
			}
			catch (NoSuchAlgorithmException e) {
				throw Caster.toPageException(e);
			}
    	}
    	throw new ApplicationException("No access, no matching authentication key found");
	}
}
