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
/**
 * Implements the CFML Function hash
 */
package lucee.runtime.functions.string;

import java.security.MessageDigest;

import lucee.commons.digest.HashUtil;
import lucee.commons.lang.StringUtil;
import lucee.commons.lang.SystemOut;
import lucee.runtime.PageContext;
import lucee.runtime.config.Config;
import lucee.runtime.crypt.FipsAlgorithm;
import lucee.runtime.exp.PageException;
import lucee.runtime.ext.function.Function;
import lucee.runtime.op.Caster;

public final class Hash implements Function {

	private static final long serialVersionUID = 1161445102079248547L;

	// function for old code in ra files calling this function
	public static String call(PageContext pc, String input) throws PageException {
		return invoke(pc.getConfig(), input, null, 1 );
	}
    public static String call(PageContext pc, String input, String algorithm) throws PageException {
		return invoke(pc.getConfig(), input, algorithm, 1 );
	}
	//////
	
	
	public static String call(PageContext pc, Object input) throws PageException {
		return invoke(pc.getConfig(), input, null, 1 );
	}

    public static String call(PageContext pc, Object input, String algorithm) throws PageException {
		return invoke(pc.getConfig(), input, algorithm, 1 );
	}
    
    public static String call(PageContext pc, Object input, String algorithm, int numIterations) throws PageException {
    	return invoke(pc.getConfig(), input, algorithm, numIterations);
	}

	public static String invoke(Config config, Object input, String algorithm, int numIterations) throws PageException {
		if (StringUtil.isEmpty(algorithm)) algorithm = FipsAlgorithm.SHA256;
		final int iteration = 5;
		numIterations = Math.max(numIterations, iteration);
		return lucee.commons.digest.Hash.hash(Caster.toString(input), algorithm, numIterations);
	}

}