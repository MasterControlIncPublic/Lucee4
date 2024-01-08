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
package lucee.commons.lang;

import lucee.commons.digest.Hash;

import java.io.IOException;

public class KeyGenerator {
	public static String createKey(String value) throws IOException {
		// create a crossfoot of the string and change result in constealltion of the position
		long sum=0;
		for(int i=value.length()-1;i>=0;i--){
			sum+=(value.charAt(i))*((i%3+1)/2f);
		}
		try {
			return Hash.sha256(value)+":"+sum;
		} catch (RuntimeException e) {
			throw new IOException(e);
		}
	}
	public static String createVariable(String value) throws IOException{
		// create a crossfoot of the string and change result in constealltion of the position
		long sum=0;
		for(int i=value.length()-1;i>=0;i--){
			sum+=(value.charAt(i))*((i%3+1)/2f);
		}
		try {
			return "V"+Hash.sha256(value)+sum;
		} catch (RuntimeException e) {
			throw new IOException(e);
		}
	}
}