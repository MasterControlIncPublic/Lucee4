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
package lucee.runtime.search.lucene2.docs;

import java.io.IOException;
import java.io.InputStream;

import lucee.commons.io.IOUtil;
import lucee.commons.io.res.Resource;

import lucee.runtime.exp.MethodNotImplementedException;
import org.apache.lucene.document.DateField;
import org.apache.lucene.document.Document;

/**
 * This class is used to create a document for the lucene search engine.
 * This should easily plug into the IndexHTML or IndexFiles that comes with
 * the lucene project.  This class will populate the following fields.
 * <table>
 *      <tr>
 *          <td>Lucene Field Name</td>
 *          <td>Description</td>
 *      </tr>
 *      <tr>
 *          <td>path</td>
 *          <td>File system path if loaded from a file</td>
 *      </tr>
 *      <tr>
 *          <td>url</td>
 *          <td>URL to PDF document</td>
 *      </tr>
 *      <tr>
 *          <td>contents</td>
 *          <td>Entire contents of PDF document, indexed but not stored</td>
 *      </tr>
 *      <tr>
 *          <td>summary</td>
 *          <td>First 500 characters of content</td>
 *      </tr>
 *      <tr>
 *          <td>modified</td>
 *          <td>The modified date/time according to the url or path</td>
 *      </tr>
 *      <tr>
 *          <td>uid</td>
 *          <td>A unique identifier for the Lucene document.</td>
 *      </tr>
 *      <tr>
 *          <td>CreationDate</td>
 *          <td>From PDF meta-data if available</td>
 *      </tr>
 *      <tr>
 *          <td>Creator</td>
 *          <td>From PDF meta-data if available</td>
 *      </tr>
 *      <tr>
 *          <td>Keywords</td>
 *          <td>From PDF meta-data if available</td>
 *      </tr>
 *      <tr>
 *          <td>ModificationDate</td>
 *          <td>From PDF meta-data if available</td>
 *      </tr>
 *      <tr>
 *          <td>Producer</td>
 *          <td>From PDF meta-data if available</td>
 *      </tr>
 *      <tr>
 *          <td>Subject</td>
 *          <td>From PDF meta-data if available</td>
 *      </tr>
 *      <tr>
 *          <td>Trapped</td>
 *          <td>From PDF meta-data if available</td>
 *      </tr>
 * </table>
 *
 */
public final class PDFDocument
{
    private static final char FILE_SEPARATOR = System.getProperty("file.separator").charAt(0);
    private static final int SUMMERY_SIZE=200;

    /**
     * private constructor because there are only static methods.
     */
    private PDFDocument()
    {
        //utility class should not be instantiated
    }
    
    /**
     * This will get a lucene document from a PDF file.
     * @param is The stream to read the PDF from.
     * @return The lucene document.
     * @throws IOException If there is an error parsing or indexing the document.
     */
    public static Document getDocument(StringBuffer content, InputStream is ) {
        Document document = new Document();
        addContent(content, document, is);
        return document;
    }

    /**
     * This will get a lucene document from a PDF file.
     * @param res The file to get the document for.
     * @return The lucene document.
     * @throws IOException If there is an error parsing or indexing the document.
     */
    public static Document getDocument( Resource res ) {
        Document document = new Document();
        FieldUtil.setMimeType(document, "application/pdf");
        //document.add(FieldUtil.UnIndexed("mime-type", "application/pdf"));
        document.add( FieldUtil.UnIndexed("path", res.getPath() ) );
        
        String uid = res.getPath().replace(FILE_SEPARATOR, '\u0000') + "\u0000" +
               DateField.timeToString(res.lastModified() );
        document.add(FieldUtil.Text("uid", uid, false));
        
        // Add the uid as a field, so that index can be incrementally maintained.
        // This field is not stored with document, it is indexed, but it is not
        // tokenized prior to indexing.
        //document.add(new Field("uid", uid, Field.Store.NO,Field.Index.UN_TOKENIZED));
        //document.add(new Field("uid", uid, false, true, false));

        InputStream is = null;
        try
        {
            is = IOUtil.toBufferedInputStream(res.getInputStream());
            addContent(null, document, is);
        }
        catch(IOException ioe) {
            
        }
        finally {
            IOUtil.closeEL(is);
        }


        // return the document

        return document;
    }

    /**
     * This will add the contents to the lucene document.
     * @param content 
     *
     * @param document The document to add the contents to.
     * @param is The stream to get the contents from.
     * @param documentLocation The location of the document, used just for debug messages.
     *
     * @throws IOException If there is an error parsing the document.
     */
    private static void addContent( StringBuffer content, Document document, InputStream is) {
        throw new MethodNotImplementedException("docs/PDFDocument", "addContent");
    }
}