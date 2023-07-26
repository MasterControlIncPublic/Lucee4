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
package lucee.runtime.tag;

import lucee.commons.io.res.Resource;
import lucee.commons.io.res.filter.ExtensionResourceFilter;
import lucee.commons.io.res.filter.ResourceFilter;
import lucee.runtime.ext.tag.BodyTagImpl;
import lucee.runtime.text.pdf.PDFDocument;
import lucee.runtime.text.pdf.PDFUtil;
import lucee.runtime.type.Struct;

public class PDF extends BodyTagImpl  {

	private static final int ACTION_ADD_WATERMARK = 0;
	private static final int ACTION_DELETE_PAGES = 1;
	private static final int ACTION_GET_INFO = 2;
	private static final int ACTION_MERGE = 3;
	private static final int ACTION_PROCESSDDX = 5;
	private static final int ACTION_PROTECT = 5;
	private static final int ACTION_READ = 6;
	private static final int ACTION_REMOVE_WATERMARK = 7;
	private static final int ACTION_SET_INFO = 8;
	private static final int ACTION_THUMBNAIL = 9;
	private static final int ACTION_WRITE = 10;
	private static final int ACTION_EXTRACT_TEXT = 11;

	
	private static final String FORMAT_JPG ="jpg";
	private static final String FORMAT_TIFF = "tiff";
	private static final String FORMAT_PNG = "png";
	
	private static final int ORDER_TIME = 0;
	private static final int ORDER_NAME = 1;
	
	private static final int RESOLUTION_HIGH = 0;
	private static final int RESOLUTION_LOW = 1;

	private static final int SAVE_OPTION_FULL = 0;
	private static final int SAVE_OPTION_INCREMENTAL = 1;
	private static final int SAVE_OPTION_LINEAR = 2;
	
	private static final int TYPE_STRING = 1;
	private static final int TYPE_XML = 2;
    
	
	private static final ExtensionResourceFilter PDF_FILTER = new ExtensionResourceFilter("pdf");
	private static final int UNDEFINED = Integer.MIN_VALUE;
	
	
	
	private int action=ACTION_PROCESSDDX;
	private boolean ascending =false;
	private Object copyFrom=null;
	private String ddxFile=null;
	private Resource destination=null;
	private Resource directory=null;
	private boolean flatten=false;
	private boolean foreground=false;
	private String format=FORMAT_JPG;
	private Object image=null;
	private Struct info=null;
	private Struct inputFiles=null;
	private Struct outputFiles=null;
	private boolean isBase64=false;
	private boolean keepBookmark=false;
	private String name=null;
	private String newOwnerPassword=null;
	private String newUserPassword=null;
	private float opacity=0.3F;
	private int order=ORDER_TIME;
	private boolean overwrite=false;
	private String pages=null;
	private String password=null;
	private int permissions=0;
	private String position=null;
	private int resolution=RESOLUTION_HIGH;
	private float rotation=0;
	private int saveOption=SAVE_OPTION_FULL;
	private int scale=25;
	private boolean showOnPrint=false;
	private Object source =null;
	private boolean stopOnError=false;
	private boolean transparent=false;
	private char version=0;
	private java.util.List<PDFParamBean> params;
	private ResourceFilter filter=null;
	private String imagePrefix=null;
	private int type=TYPE_XML;
	
	@Override
	public void release() {
		super.release();
		throw new lucee.runtime.exp.TagNotImplementedException("PDF");
	}
	
	
	
	/**
	 * @param imagePrefix the imagePrefix to set
	 */
	public void setImageprefix(String imagePrefix) {
		throw new lucee.runtime.exp.TagNotImplementedException("PDF");
	}



	/**
	 * @param action the action to set
	 */
	public void setAction(String strAction) {
		throw new lucee.runtime.exp.TagNotImplementedException("PDF");
		
	}
	

	public void setType(String strType) {
		throw new lucee.runtime.exp.TagNotImplementedException("PDF");
		
	}
	
	/** 
	*  sets a filter pattern
	* @param pattern
	**/
	public void setFilter(String pattern)	{
		throw new lucee.runtime.exp.TagNotImplementedException("PDF");
	}
	
	/**
	 * @param ascending the ascending to set
	 */
	public void setAscending(boolean ascending) {
		throw new lucee.runtime.exp.TagNotImplementedException("PDF");
	}
	/**
	 * @param copyFrom the copyFrom to set
	 */
	public void setCopyfrom(Object copyFrom) {
		throw new lucee.runtime.exp.TagNotImplementedException("PDF");
	}
	/**
	 * @param ddxFile the ddxFile to set
	 */
	public void setDdxfile(String ddxFile) {
		throw new lucee.runtime.exp.TagNotImplementedException("PDF");
	}
	/**
	 * @param destination the destination to set
	 */
	public void setDestination(String destination) {
		throw new lucee.runtime.exp.TagNotImplementedException("PDF");
	}
	/**
	 * @param directory the directory to set
	 */
	public void setDirectory(String directory) {
		throw new lucee.runtime.exp.TagNotImplementedException("PDF");
	}
	/**
	 * @param encrypt the encrypt to set
	 */
	public void setEncrypt(String strEncrypt) {
		throw new lucee.runtime.exp.TagNotImplementedException("PDF");
	}
	/**
	 * @param flatten the flatten to set
	 */
	public void setFlatten(boolean flatten) {
		throw new lucee.runtime.exp.TagNotImplementedException("PDF");
	}
	/**
	 * @param foreground the foreground to set
	 */
	public void setForeground(boolean foreground) {
		throw new lucee.runtime.exp.TagNotImplementedException("PDF");
	}
	/**
	 * @param format the format to set
	 */
	public void setFormat(String strFormat) {
		throw new lucee.runtime.exp.TagNotImplementedException("PDF");
	}
	/**
	 * @param image the image to set
	 */
	public void setImage(Object image) {
		throw new lucee.runtime.exp.TagNotImplementedException("PDF");
	}
	/**
	 * @param prefix the prefix to set
	 */
	public void setPrefix(String prefix) {
		throw new lucee.runtime.exp.TagNotImplementedException("PDF");
	}
	/**
	 * @param info the info to set
	 */
	public void setInfo(Struct info) {
		throw new lucee.runtime.exp.TagNotImplementedException("PDF");
	}
	/**
	 * @param inputFiles the inputFiles to set
	 */
	public void setInputfiles(Struct inputFiles) {
		throw new lucee.runtime.exp.TagNotImplementedException("PDF");
	}
	/**
	 * @param outputFiles the outputFiles to set
	 */
	public void setOutputfiles(Struct outputFiles) {
		throw new lucee.runtime.exp.TagNotImplementedException("PDF");
	}
	/**
	 * @param isBase64 the isBase64 to set
	 */
	public void setIsbase64(boolean isBase64) {
		throw new lucee.runtime.exp.TagNotImplementedException("PDF");
	}
	/**
	 * @param keepBookmark the keepBookmark to set
	 */
	public void setKeepbookmark(boolean keepBookmark) {
		throw new lucee.runtime.exp.TagNotImplementedException("PDF");
	}
	/**
	 * @param name the name to set
	 */
	public void setName(String name) {
		throw new lucee.runtime.exp.TagNotImplementedException("PDF");
	}
	/**
	 * @param newOwnerPassword the newOwnerPassword to set
	 */
	public void setNewownerpassword(String newOwnerPassword) {
		throw new lucee.runtime.exp.TagNotImplementedException("PDF");
	}
	/**
	 * @param newUserPassword the newUserPassword to set
	 */
	public void setNewuserpassword(String newUserPassword) {
		throw new lucee.runtime.exp.TagNotImplementedException("PDF");
	}
	/**
	 * @param opacity the opacity to set
	 */
	public void setOpacity(double opacity) {
		throw new lucee.runtime.exp.TagNotImplementedException("PDF");
	}
	/**
	 * @param order the order to set
	 */
	public void setOrder(String strOrder) {
		throw new lucee.runtime.exp.TagNotImplementedException("PDF");
	}
	/**
	 * @param overwrite the overwrite to set
	 */
	public void setOverwrite(boolean overwrite) {
		throw new lucee.runtime.exp.TagNotImplementedException("PDF");
	}
	/**
	 * @param pages the pages to set
	 */
	public void setPages(String pages) {
		throw new lucee.runtime.exp.TagNotImplementedException("PDF");
	}
	/**
	 * @param password the password to set
	 */
	public void setPassword(String password) {
		throw new lucee.runtime.exp.TagNotImplementedException("PDF");
	}
	/**
	 * @param permissions the permissions to set
	 */
	public void setPermissions(String strPermissions) {
		throw new lucee.runtime.exp.TagNotImplementedException("PDF");
	}	
	/**
	 * @param position the position to set
	 */
	public void setPosition(String position) {
		throw new lucee.runtime.exp.TagNotImplementedException("PDF");
	}
	/**
	 * @param resolution the resolution to set
	 */
	public void setResolution(String strResolution) {
		throw new lucee.runtime.exp.TagNotImplementedException("PDF");
	}
	
	/**
	 * @param rotation the rotation to set
	 */
	public void setRotation(double rotation) {
		throw new lucee.runtime.exp.TagNotImplementedException("PDF");
	}
	
	/**
	 * @param saveOption the saveOption to set
	 */
	public void setSaveoption(String strSaveOption) {
		throw new lucee.runtime.exp.TagNotImplementedException("PDF");
	}
	
	/**
	 * @param scale the scale to set
	 */
	public void setScale(double scale) {
		throw new lucee.runtime.exp.TagNotImplementedException("PDF");
	}
	
	/**
	 * @param showOnPrint the showOnPrint to set
	 */
	public void setShowonprint(boolean showOnPrint) {
		throw new lucee.runtime.exp.TagNotImplementedException("PDF");
	}
	
	/**
	 * @param source the source to set
	 */
	public void setSource(Object source) {
		throw new lucee.runtime.exp.TagNotImplementedException("PDF");
	}
	/**
	 * @param stopOnError the stopOnError to set
	 */
	public void setStoponerror(boolean stopOnError) {
		throw new lucee.runtime.exp.TagNotImplementedException("PDF");
	}
	/**
	 * @param transparent the transparent to set
	 */
	public void setTransparent(boolean transparent) {
		throw new lucee.runtime.exp.TagNotImplementedException("PDF");
	}
	/**
	 * @param version the version to set
	 */
	public void setVersion(double version) {
		throw new lucee.runtime.exp.TagNotImplementedException("PDF");
	}
	
	@Override
	public int doStartTag()	{
		throw new lucee.runtime.exp.TagNotImplementedException("PDF");
	}

	@Override
	public void doInitBody()	{
		
	}
	
	@Override
	public int doAfterBody()	{
		throw new lucee.runtime.exp.TagNotImplementedException("PDF");
	}
	
	@Override
	public int doEndTag() {
		throw new lucee.runtime.exp.TagNotImplementedException("PDF");
	}
	
	
	
	
	private void doActionWrite() {
		throw new lucee.runtime.exp.TagNotImplementedException("PDF");
	}



	private void doActionThumbnail() {
		throw new lucee.runtime.exp.TagNotImplementedException("PDF");
		
		
		
	}
	
	
	
	
	private void doActionAddWatermark() {
		throw new lucee.runtime.exp.TagNotImplementedException("PDF");
	}
	
	private void doActionRemoveWatermark() {
		throw new lucee.runtime.exp.TagNotImplementedException("PDF");
	}
	
	private void doActionDeletePages() {
		throw new lucee.runtime.exp.TagNotImplementedException("PDF");
	}
	
	
	private void doActionMerge() {
		throw new lucee.runtime.exp.TagNotImplementedException("PDF");
	}
	private void doActionRead() {
		throw new lucee.runtime.exp.TagNotImplementedException("PDF");
	}
	
	private void doActionProtect() {
		throw new lucee.runtime.exp.TagNotImplementedException("PDF");
		
	}
	

	

	private void doActionSetInfo() {
		throw new lucee.runtime.exp.TagNotImplementedException("PDF");
	}
	
	private void doActionGetInfo() {
		throw new lucee.runtime.exp.TagNotImplementedException("PDF");
		
	}
	private void doActionExtractText() {
		throw new lucee.runtime.exp.TagNotImplementedException("PDF");
	}
	
	private Object allowed(boolean encrypted, int permissions, int permission) {
		throw new lucee.runtime.exp.TagNotImplementedException("PDF");
	}
	

	private PDFDocument toPDFDocument(Object source,String password, Resource directory) {
		throw new lucee.runtime.exp.TagNotImplementedException("PDF");
	}
	
	/*private byte[] toBinary(Object source) throws ExpressionException, IOException {
		
		if(source instanceof PDFDocument) 
			return toBinary(((PDFDocument)source).getResource());
		if(Decision.isBinary(source)){
			return Caster.toBinary(source);
		}
		if(source instanceof Resource){ 
			return IOUtil.toBytes((Resource)source);
		}
		if(source instanceof String){
			if(directory!=null) {
				Resource res = directory.getRealResource((String)source);
				if(!res.isFile()){
					Resource res2 = ResourceUtil.toResourceNotExisting(pageContext, (String)source);
					if(res2.isFile())
						res=res2;
					else 
						throw new ExpressionException("file or directory "+res+" not exist");
				}
				return IOUtil.toBytes(res);	
			}
			return IOUtil.toBytes(ResourceUtil.toResourceExisting(pageContext, (String)source));	
		}
		
		throw new CasterException(source,PdfReader.class);
	}*/
	
	protected void setParam(PDFParamBean param) {
		throw new lucee.runtime.exp.TagNotImplementedException("PDF");
	}
	
	
	

}
