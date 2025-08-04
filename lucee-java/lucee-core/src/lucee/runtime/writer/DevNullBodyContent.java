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
package lucee.runtime.writer;

import java.io.IOException;
import java.io.Reader;
import java.io.StringReader;
import java.io.Writer;

import jakarta.servlet.jsp.JspWriter;
import jakarta.servlet.jsp.tagext.BodyContent;


/**
 * BodyContent implementation that dont store input
 */
public final class DevNullBodyContent extends BodyContent {
	
	private JspWriter enclosingWriter;
	
	/**
	 * default constructor
	 */
	public DevNullBodyContent() {
		super(null);
	}
	
	/**
	 * @see jakarta.servlet.jsp.tagext.BodyContent#getReader()
	 */
	public Reader getReader() {
		return new StringReader("");
	}
	
	/**
	 * @see jakarta.servlet.jsp.tagext.BodyContent#getString()
	 */
	public String getString() {
		return "";
	}
	
	/**
	 * 
	 * @see jakarta.servlet.jsp.tagext.BodyContent#writeOut(java.io.Writer)
	 */
	public void writeOut(Writer writer) {
		
	}
	
	/**
	 * @see jakarta.servlet.jsp.JspWriter#newLine()
	 */
	public void newLine() {
		
	}
	
	/**
	 * @see jakarta.servlet.jsp.JspWriter#print(boolean)
	 */
	public void print(boolean b) {
	}
	
	/**
	 * @see jakarta.servlet.jsp.JspWriter#print(char)
	 */
	public void print(char c) {
	}
	
	/**
	 * @see jakarta.servlet.jsp.JspWriter#print(int)
	 */
	public void print(int i) {
	}
	
	/**
	 * @see jakarta.servlet.jsp.JspWriter#print(long)
	 */
	public void print(long l) {
	}
	
	/**
	 * @see jakarta.servlet.jsp.JspWriter#print(float)
	 */
	public void print(float f) {
	}
	
	/**
	 * @see jakarta.servlet.jsp.JspWriter#print(double)
	 */
	public void print(double d) {
	}
	
	/**
	 * @see jakarta.servlet.jsp.JspWriter#print(char[])
	 */
	public void print(char[] c) {
	}
	
	/**
	 * @see jakarta.servlet.jsp.JspWriter#print(java.lang.String)
	 */
	public void print(String str) {
	}
	
	/**
	 * @see jakarta.servlet.jsp.JspWriter#print(java.lang.Object)
	 */
	public void print(Object o) {
	}
	
	/**
	 * @see jakarta.servlet.jsp.JspWriter#println()
	 */
	public void println() {
	}
	
	/**
	 * @see jakarta.servlet.jsp.JspWriter#println(boolean)
	 */
	public void println(boolean b) {
	}
	
	/**
	 * @see jakarta.servlet.jsp.JspWriter#println(char)
	 */
	public void println(char c) {
	}
	
	/**
	 * @see jakarta.servlet.jsp.JspWriter#println(int)
	 */
	public void println(int i) {
	}
	
	/**
	 * @see jakarta.servlet.jsp.JspWriter#println(long)
	 */
	public void println(long l) {
	}
	
	/**
	 * @see jakarta.servlet.jsp.JspWriter#println(float)
	 */
	public void println(float f) {
	}
	
	/**
	 * @see jakarta.servlet.jsp.JspWriter#println(double)
	 */
	public void println(double d) {
	}
	
	/**
	 * @see jakarta.servlet.jsp.JspWriter#println(char[])
	 */
	public void println(char[] c) {
	}
	
	/**
	 * @see jakarta.servlet.jsp.JspWriter#println(java.lang.String)
	 */
	public void println(String str) {
	}
	
	/**
	 * @see jakarta.servlet.jsp.JspWriter#println(java.lang.Object)
	 */
	public void println(Object o) {
	}
	
	/**
	 * @see jakarta.servlet.jsp.JspWriter#clear()
	 */
	public void clear() {
	}
	
	/**
	 * @see jakarta.servlet.jsp.JspWriter#clearBuffer()
	 */
	public void clearBuffer() {
	}
	
	/**
	 * @see java.io.Writer#close()
	 */
	public void close() throws IOException {
		enclosingWriter.close();
	}
	/**
	 * @see jakarta.servlet.jsp.JspWriter#getRemaining()
	 */
	public int getRemaining() {
		return 0;
	}
	
	/**
	 * @see java.io.Writer#write(char[], int, int)
	 */
	public void write(char[] cbuf, int off, int len) {
	}
	
	/**
	 * @see jakarta.servlet.jsp.tagext.BodyContent#clearBody()
	 */
	public void clearBody() {
		
	}
	/**
	 * @see java.io.Writer#flush()
	 */
	public void flush() throws IOException {
		enclosingWriter.flush();
	}
	
	/**
	 * @see jakarta.servlet.jsp.tagext.BodyContent#getEnclosingWriter()
	 */
	public JspWriter getEnclosingWriter() {
		return enclosingWriter;
	}
	
	/**
	 * @see jakarta.servlet.jsp.JspWriter#getBufferSize()
	 */
	public int getBufferSize() {
		return 0;
	}
	/**
	 * @see jakarta.servlet.jsp.JspWriter#isAutoFlush()
	 */
	public boolean isAutoFlush() {
		return false;
	}
}