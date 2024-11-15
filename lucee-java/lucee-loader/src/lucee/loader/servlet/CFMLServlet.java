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
package lucee.loader.servlet;

import java.io.IOException;

import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import lucee.loader.engine.CFMLEngineFactory;

/**
 */
public class CFMLServlet extends LuceeServlet {

	private static final long serialVersionUID = -1878214660283329587L;
	
	/**
     * @see jakarta.servlet.Servlet#init(jakarta.servlet.ServletConfig)
     */
    public void init(ServletConfig sg) throws ServletException {
        super.init(sg);
        engine=CFMLEngineFactory.getInstance(sg,this);
    }
    /**
     * @see jakarta.servlet.http.HttpServlet#service(jakarta.servlet.http.HttpServletRequest, jakarta.servlet.http.HttpServletResponse)
     */
    protected void service(HttpServletRequest req, HttpServletResponse rsp) throws ServletException, IOException {
        engine.serviceCFML(this,req,rsp);
    }
}
