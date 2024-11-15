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
package lucee.runtime.ext.tag;

import jakarta.servlet.jsp.JspException;
import jakarta.servlet.jsp.tagext.Tag;

import lucee.loader.engine.CFMLEngineFactory;
import lucee.runtime.PageContext;
import lucee.runtime.exp.PageException;
import lucee.runtime.util.Excepton;

/**
 * Implementation of the Tag
 */
public abstract class TagSupport implements Tag {

    /**
     * Field <code>pageContext</code>
     */
    protected PageContext pageContext;
    
    private Tag parent;
       
    /**
     * sets a Lucee PageContext
     * @param pageContext
     */
    public void setPageContext(PageContext pageContext) {
        this.pageContext=pageContext;
    }
    /**
     * @see jakarta.servlet.jsp.tagext.Tag#setPageContext(jakarta.servlet.jsp.PageContext)
     */
    public void setPageContext(jakarta.servlet.jsp.PageContext pageContext) {
        this.pageContext=(PageContext) pageContext;
    }

    /**
     * @see jakarta.servlet.jsp.tagext.Tag#setParent(jakarta.servlet.jsp.tagext.Tag)
     */
    public void setParent(Tag parent) {
        this.parent=parent;
    }

    /**
     * @see jakarta.servlet.jsp.tagext.Tag#getParent()
     */
    public Tag getParent() {
        return parent;
    }

    /**
     * @see jakarta.servlet.jsp.tagext.Tag#doStartTag()
     */
    public int doStartTag() throws JspException {
        return SKIP_BODY;
    }

    /**
     * @see jakarta.servlet.jsp.tagext.Tag#doEndTag()
     */
    public int doEndTag() throws JspException {
        return EVAL_PAGE;
    }

    /**
     * @see jakarta.servlet.jsp.tagext.Tag#release()
     */
    public void release() {
        pageContext=null;
        parent=null;
    }    
    
    /**
     * check if value is not empty
     * @param tagName 
     * @param actionName 
     * @param attributeName 
     * @param attribute 
     * @throws PageException
     */
    public void required(String tagName, String actionName, String attributeName, Object attribute) throws PageException {
        if(attribute==null) {
            Excepton util = CFMLEngineFactory.getInstance().getExceptionUtil();
            throw util.createApplicationException("Attribute ["+attributeName+"] for tag ["+tagName+"] is required if attribute action has the value ["+actionName+"]");
        }
    }
    
    
    
}