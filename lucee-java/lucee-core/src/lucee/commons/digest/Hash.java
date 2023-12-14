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
package lucee.commons.digest;

import java.nio.charset.Charset;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.NoSuchProviderException;

import lucee.commons.io.CharsetUtil;
import lucee.runtime.crypt.FipsProvider;

public class Hash {
	
	public static final char[] ENCODING_HEX = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f'};
	public static final char[] ENCODING_HEXUC = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F'};
	private static final byte[] DEL=new byte[]{58};

	public static final String ALGORITHM_SHA_256="SHA-256";
	public static final String ALGORITHM_SHA_384="SHA-384";
	public static final String ALGORITHM_SHA_512="SHA-512";
	public static final String ALGORITHM_SHA="SHA";
	
	// SHA
	public static String sha(byte[] data) {
		return hash(data, ALGORITHM_SHA,ENCODING_HEX);
	}
	
	public static String sha(String str) {
		return hash(str, ALGORITHM_SHA,ENCODING_HEX,CharsetUtil.UTF8);
	}
	
	public static String sha(String str,Charset charset) {
		return hash(str, ALGORITHM_SHA,ENCODING_HEX,charset);
	}

	// SHA256
	public static String sha256(byte[] data) {
		return hash(data, ALGORITHM_SHA_256,ENCODING_HEX);
	}
	
	public static String sha256(String str) {
		return hash(str, ALGORITHM_SHA_256,ENCODING_HEX,CharsetUtil.UTF8);
	}
	
	public static String sha256(String str,Charset charset) {
		return hash(str, ALGORITHM_SHA_256,ENCODING_HEX,charset);
	}

	// SHA384
	public static String sha384(byte[] data) {
		return hash(data, ALGORITHM_SHA_384,ENCODING_HEX);
	}
	
	public static String sha384(String str) {
		return hash(str, ALGORITHM_SHA_384,ENCODING_HEX,CharsetUtil.UTF8);
	}
	
	public static String sha384(String str,Charset charset) {
		return hash(str, ALGORITHM_SHA_384,ENCODING_HEX,charset);
	}

	// SHA384
	public static String sha512(byte[] data) {
		return hash(data, ALGORITHM_SHA_512,ENCODING_HEX);
	}
	
	public static String sha512(String str) {
		return hash(str, ALGORITHM_SHA_512,ENCODING_HEX,CharsetUtil.UTF8);
	}
	
	public static String sha512(String str,Charset charset) {
		return hash(str, ALGORITHM_SHA_512,ENCODING_HEX,charset);
	}

	public static String hash(String str, String nonce, String algorithm,char[] encoding) {
		try {
			MessageDigest md=MessageDigest.getInstance(algorithm, FipsProvider.BCFIPS);
			md.reset();
			md.update(toBytes(str, CharsetUtil.UTF8));
			md.update(DEL);
			md.update(toBytes(nonce, CharsetUtil.UTF8));
			return new String( enc(md.digest(),encoding)); // no charset needed because all characters are below us-ascii (hex)
		} catch (NoSuchAlgorithmException | NoSuchProviderException ex) {
			throw new RuntimeException("Missing Algorithm: " + algorithm, ex);
		}
	}

	public static String hash(String input, String algorithm, int numIterations) {
		return hash(input, algorithm, numIterations, ENCODING_HEXUC);
	}
	
	public static String hash(String str, String algorithm, int numIterations,char[] encoding) {
		try {
			MessageDigest md=MessageDigest.getInstance(algorithm),mdc;
			for(int i=0;i<numIterations;i++){
				mdc=(MessageDigest) md.clone();
				mdc.reset();
			    mdc.update(toBytes(str, CharsetUtil.UTF8));
			    str=new String(enc(mdc.digest(),encoding));
			}
			return str;
		}
		catch (NoSuchAlgorithmException ex) {
			throw new RuntimeException("Missing Algorithm: " + algorithm, ex);
		}
		catch (CloneNotSupportedException e) {}
		
		// if not possible to clone the MessageDigest create always a new instance
		for(int i=0;i<numIterations;i++){
			str=hash(str, algorithm,encoding,CharsetUtil.UTF8);
		}
		return str;
	}
	
	public static String hash(String str, String algorithm,char[] encoding, Charset charset) {
		return hash(toBytes(str, charset), algorithm,encoding); 
	}
	
	public static String hash(byte[] data, String algorithm,char[] encoding) {
		try {
			MessageDigest md=MessageDigest.getInstance(algorithm);
			md.reset();
			md.update(data);
			return new String( enc(md.digest(),encoding)); // no charset needed because all characters are below us-ascii (hex)
		} catch (NoSuchAlgorithmException ex) {
			throw new RuntimeException("Missing Algorithm: " + algorithm, ex);
		}
	}
	
	private static byte[] toBytes(String str, Charset charset) {
		if (str==null) return null;
		return str.getBytes(charset);
	}
	
	public static String toHexString(byte[] data, boolean upperCase) {
		return new String(enc(data, upperCase?ENCODING_HEXUC:ENCODING_HEX));
	}
	private static char[] enc(byte[] data,char[] enc) {
		
		int len = data.length;
		char[] out = new char[len << 1];
		// two characters form the hex value.
		for (int i = 0, j = 0; i < len; i++) {
			out[j++] = enc[(0xF0 & data[i]) >>> 4];
			out[j++] = enc[0x0F & data[i]];
		}
		return out;
	}
}
