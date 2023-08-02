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
package lucee.runtime.text.pdf;

import java.io.IOException;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;

import lucee.commons.io.IOUtil;
import lucee.commons.io.res.Resource;
import lucee.commons.lang.StringUtil;
import lucee.runtime.PageContext;
import lucee.runtime.dump.DumpData;
import lucee.runtime.dump.DumpProperties;
import lucee.runtime.dump.DumpTable;
import lucee.runtime.exp.PageException;
import lucee.runtime.type.Collection;
import lucee.runtime.type.Struct;
import lucee.runtime.type.dt.DateTime;
import lucee.runtime.type.util.StructSupport;

public class PDFDocument extends StructSupport implements Struct {

	private byte[] barr;
	private String password;
	private Resource resource;
	private Set<Integer> pages;

	public PDFDocument(byte[] barr, String password) {
		this.barr=barr;
		this.password=password;
	}

	public PDFDocument(Resource resource, String password) {
		this.resource=resource;
		this.password=password;
	}

	public PDFDocument(byte[] barr, Resource resource, String password) {
		this.resource=resource;
		this.barr=barr;
		this.password=password;
	}
	

	@Override
	public void clear() {
		getInfo().clear();
	}


	@Override
	public boolean containsKey(Key key) {
		return getInfo().containsKey(key);
	}

	@Override
	public Collection duplicate(boolean deepCopy) {
		PDFDocument duplicate=new PDFDocument(barr,resource,password);
		return duplicate;
	}
	

	@Override
	public Object get(Key key) throws PageException {
		return getInfo().get(key);
	}

	@Override
	public Object get(Key key, Object defaultValue) {
		return getInfo().get(key, defaultValue);
	}

	@Override
	public Key[] keys() {
		return getInfo().keys();
	}

	@Override
	public Object remove(Key key) throws PageException {
		return getInfo().remove(key);
	}

	@Override
	public Object removeEL(Key key) {
		return getInfo().removeEL(key);
	}

	@Override
	public Object set(Key key, Object value) throws PageException {
		return getInfo().set(key, value);
	}

	@Override
	public Object setEL(Key key, Object value) {
		return getInfo().setEL(key, value);
	}

	@Override
	public int size() {
		return getInfo().size();
	}

	@Override
	public DumpData toDumpData(PageContext pageContext, int maxlevel,DumpProperties properties) {
		
		DumpData dd = getInfo().toDumpData(pageContext, maxlevel,properties);
		if(dd instanceof DumpTable)((DumpTable)dd).setTitle("Struct (PDFDocument)");
		return dd;
	}

	@Override
	public Iterator<Collection.Key> keyIterator() {
		return getInfo().keyIterator();
	}
    
    @Override
	public Iterator<String> keysAsStringIterator() {
    	return getInfo().keysAsStringIterator();
    }
	
	@Override
	public Iterator<Entry<Key, Object>> entryIterator() {
		return getInfo().entryIterator();
	}
	
	@Override
	public Iterator<Object> valueIterator() {
		return getInfo().valueIterator();
	}

	@Override
	public boolean castToBooleanValue() throws PageException {
		return getInfo().castToBooleanValue();
	}
    
    @Override
    public Boolean castToBoolean(Boolean defaultValue) {
        return getInfo().castToBoolean(defaultValue);
    }

	@Override
	public DateTime castToDateTime() throws PageException {
		return getInfo().castToDateTime();
	}
    
    @Override
    public DateTime castToDateTime(DateTime defaultValue) {
        return getInfo().castToDateTime(defaultValue);
    }

	@Override
	public double castToDoubleValue() throws PageException {
		return getInfo().castToDoubleValue();
	}
    
    @Override
    public double castToDoubleValue(double defaultValue) {
        return getInfo().castToDoubleValue(defaultValue);
    }

	@Override
	public String castToString() throws PageException {
		return getInfo().castToString();
	}
	@Override
	public String castToString(String defaultValue) {
		return getInfo().castToString(defaultValue);
	}

	@Override
	public int compareTo(String str) throws PageException {
		return getInfo().compareTo(str);
	}

	@Override
	public int compareTo(boolean b) throws PageException {
		return getInfo().compareTo(b);
	}

	@Override
	public int compareTo(double d) throws PageException {
		return getInfo().compareTo(d);
	}

	@Override
	public int compareTo(DateTime dt) throws PageException {
		return getInfo().compareTo(dt);
	}
///////////////////////////////////////////////
	
	private String getFilePath() {
		if(resource==null) return "";
		return resource.getAbsolutePath();
	}

	public Struct getInfo()  {

		throw new lucee.runtime.exp.MethodNotImplementedException(this.getClass().getName(), "getInfo");
	}
	

	

	private static Object allowed(boolean encrypted, int permissions, int permission) {
		return (!encrypted || (permissions&permission)>0)?"Allowed":"Not Allowed";
	}



	public void setPages(String strPages) throws PageException {
		if(StringUtil.isEmpty(strPages))return;
		if(pages==null)
			pages=new HashSet<Integer>();
		PDFUtil.parsePageDefinition(pages,strPages);
	}

	public Set<Integer> getPages() {
		//if(pages==null)pages=new HashSet();
		return pages;
	}

	public Resource getResource() {
		return resource;
	}
	public byte[] getRaw() throws IOException {
		if(barr!=null)return barr;
		return IOUtil.toBytes(resource);
	}

	@Override
	public boolean containsValue(Object value) {
		return getInfo().containsValue(value);
	}

	@Override
	public java.util.Collection values() {
		return getInfo().values();
	}
}
