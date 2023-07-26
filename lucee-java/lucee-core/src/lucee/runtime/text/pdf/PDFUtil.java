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
import java.io.OutputStream;
import java.io.StringWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import lucee.commons.io.IOUtil;
import lucee.commons.io.res.Resource;
import lucee.commons.lang.StringUtil;
import lucee.runtime.PageContext;
import lucee.runtime.exp.ApplicationException;
import lucee.runtime.exp.CasterException;
import lucee.runtime.exp.PageException;
import lucee.runtime.img.Image;
import lucee.runtime.op.Caster;
import lucee.runtime.op.Constants;
import lucee.runtime.op.Decision;

import org.pdfbox.exceptions.CryptographyException;
import org.pdfbox.exceptions.InvalidPasswordException;
import org.pdfbox.pdmodel.PDDocument;
import org.pdfbox.util.PDFText2HTML;

public class PDFUtil {
	
	/**
	 * convert a string list of permission 
	 * @param strPermissions
	 * @return
	 * @throws PageException
	 */
	public static int toPermissions(String strPermissions) throws PageException {
		if(strPermissions==null) return 0;
		int permissions=0;
    	strPermissions=strPermissions.trim();
		
    	String[] arr = lucee.runtime.type.util.ListUtil.toStringArray(lucee.runtime.type.util.ListUtil.listToArrayRemoveEmpty(strPermissions, ','));
		for(int i=0;i<arr.length;i++) {
			permissions=add(permissions,toPermission(arr[i]));
		}
		return permissions;
	}

	/**
	 * convert a string defintion of a permision in a integer Constant (PdfWriter.ALLOW_XXX)
	 * @param strPermission
	 * @return
	 * @throws ApplicationException
	 */
	public static int toPermission(String strPermission) {
		throw new lucee.runtime.exp.MethodNotImplementedException(PDFUtil.class.getName(), "toPermission");
	}

	
	private static int add(int permissions, int permission) {
		if(permission==0 || (permissions&permission)>0)return permissions;
		return permissions+permission;
	}
	
	
	/**
	 * @param docs
	 * @param os
	 * @param removePages if true, pages defined in PDFDocument will be removed, otherwise all other pages will be removed
	 * @param version 
	 * @throws PageException 
	 * @throws IOException
	 */
	public static void concat(PDFDocument[] docs, OutputStream os, boolean keepBookmark, boolean removePages, boolean stopOnError, char version) throws PageException, IOException {
		throw new lucee.runtime.exp.MethodNotImplementedException(PDFUtil.class.getName(), "concat");
	}
	
	
	private static void removeBookmarks(List bookmarks,Set pages, boolean removePages) {
		int size = bookmarks.size();
		for(int i=size-1;i>=0;i--) {
			if(removeBookmarks((Map) bookmarks.get(i),pages, removePages))
				bookmarks.remove(i);
		}
	}
	
	private static boolean removeBookmarks(Map bookmark, Set pages, boolean removePages) {
		List kids=(List) bookmark.get("Kids");
		if(kids!=null)removeBookmarks(kids,pages,removePages);
		Integer page=Caster.toInteger(lucee.runtime.type.util.ListUtil.first((String) bookmark.get("Page")," ",true),Constants.INTEGER_MINUS_ONE);
		return removePages==(pages!=null && pages.contains(page));
	}

	public static Set parsePageDefinition(String strPages) throws PageException {
		if(StringUtil.isEmpty(strPages)) return null;
		HashSet<Integer> set=new HashSet<Integer>();
		parsePageDefinition(set, strPages);
		return set;
	}
	public static void parsePageDefinition(Set<Integer> pages, String strPages) throws PageException {
		if(StringUtil.isEmpty(strPages)) return;
		String[] arr = lucee.runtime.type.util.ListUtil.toStringArrayTrim(lucee.runtime.type.util.ListUtil.listToArrayRemoveEmpty(strPages, ','));
		int index,from,to;
		for(int i=0;i<arr.length;i++){
			index=arr[i].indexOf('-');
			if(index==-1)pages.add(Caster.toInteger(arr[i].trim()));
			else {
				from=Caster.toIntValue(arr[i].substring(0,index).trim());
				to=Caster.toIntValue(arr[i].substring(index+1).trim());
				for(int y=from;y<=to;y++){
					pages.add(Integer.valueOf(y));
				}
			}
		}
	}
	
	
	

	 
	public static void encrypt(PDFDocument doc, OutputStream os, String newUserPassword, String newOwnerPassword, int permissions, int encryption) throws ApplicationException, IOException {
		throw new lucee.runtime.exp.MethodNotImplementedException("PDFUtil", "encrypt");
	}

	public static HashMap generateGoToBookMark(String title,int page) {
		return generateGoToBookMark(title,page, 0, 731);
	}
	
	public static HashMap generateGoToBookMark(String title,int page, int x, int y) {
		HashMap map=new HashMap();
		map.put("Title", title);
		map.put("Action", "GoTo");
		map.put("Page", page+" XYZ "+x+" "+y+" null");
		
		return map;
	}

	public static void setChildBookmarks(Map parent, List children) {
		Object kids = parent.get("Kids");
		if(kids instanceof List){
			((List)kids).addAll(children);
		}
		else parent.put("Kids", children);
	}
	
	
	/*public static void main(String[] args) throws IOException {
		
		
		
		PdfReader pr = new PdfReader("/Users/mic/Projects/Lucee/webroot/jm/test/tags/pdf/Parallels.pdf");
		List bm = SimpleBookmark.getBookmark(pr);
		print.out(bm);
		ByteArrayOutputStream os = new ByteArrayOutputStream();
		try {
			SimpleBookmark.exportToXML(bm, os, "UTF-8",false);
		}
		finally {
			IOUtil.closeEL(os);
		}
		print.out("*********************************");
		print.out(IOUtil.toString(os.toByteArray(), "UTF-8"));
	}*/
	
	public static Image toImage(byte[] input,int page) throws PageException, IOException  {
		 return PDF2Image.getInstance().toImage(input, page);
	}

	public static void writeImages(byte[] input,Set pages,Resource outputDirectory, String prefix,
			String format, int scale, boolean overwrite, boolean goodQuality,boolean transparent) throws PageException, IOException {
		PDF2Image.getInstance().writeImages(input, pages, outputDirectory, prefix, format, scale, overwrite, goodQuality, transparent);
	}

	public static Object extractText(PDFDocument doc, Set<Integer> pageNumbers) throws IOException, CryptographyException, InvalidPasswordException {
		PDDocument pdDoc = doc.toPDDocument();
		//PDPageNode pages = pdDoc.getDocumentCatalog().getPages();
		//pages.
		//pdDoc.getDocumentCatalog().
		
		/*Iterator<Integer> it = pageNumbers.iterator();
		int p;
		while(it.hasNext()){
			p=it.next().intValue();
		
			pdDoc.getDocumentCatalog().getPages()
		}
		*/
		
		//print.o(pages);
		
		
		
		//pdDoc.
		
		
		//PDFTextStripperByArea  stripper = new PDFTextStripperByArea();
		//PDFHighlighter  stripper = new PDFHighlighter();
		PDFText2HTML  stripper = new PDFText2HTML();
		//PDFTextStripper stripper = new PDFTextStripper();
	    StringWriter writer = new StringWriter();
	    stripper.writeText(pdDoc, writer);
	    
		
		return writer.toString();
	}
}
