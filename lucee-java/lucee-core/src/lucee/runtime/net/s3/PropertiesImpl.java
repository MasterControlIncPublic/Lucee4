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
package lucee.runtime.net.s3;

import lucee.commons.io.res.type.s3.S3Constants;
import lucee.runtime.type.Struct;
import lucee.runtime.type.StructImpl;


public final class PropertiesImpl implements Properties {
	private String accessKeyId;
	private String secretAccessKey;
	private int defaultLocation=S3Constants.STORAGE_UNKNOWN;

	public Struct toStruct() {
		Struct sct=new StructImpl();

		sct.setEL("accessKeyId", accessKeyId);
		sct.setEL("awsSecretKey", secretAccessKey);
		sct.setEL("defaultLocation", "");
		sct.setEL("host", "");
		
		
		return sct;
	}
	
	/**
	 * @return the accessKeyId
	 */
	public String getAccessKeyId() {
		return accessKeyId;
	}

	@Override
	public String getHost() {
		return "";
	}

	/**
	 * @return the defaultLocation
	 */
	public int getDefaultLocation() {
		return defaultLocation;
	}
	/**
	 * @param accessKeyId the accessKeyId to set
	 */
	public void setAccessKeyId(String accessKeyId) {
		this.accessKeyId = accessKeyId;
	}
	/**
	 * @return the secretAccessKey
	 */
	public String getSecretAccessKey() {
		return secretAccessKey;
	}
	/**
	 * @param secretAccessKey the secretAccessKey to set
	 */
	public void setSecretAccessKey(String secretAccessKey) {
		this.secretAccessKey = secretAccessKey;
	}
	
	@Override
	public String toString(){
		return "accessKeyId:"+accessKeyId+";defaultLocation:"+defaultLocation+";secretAccessKey:"+secretAccessKey;
	}
}
