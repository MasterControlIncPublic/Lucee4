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
package lucee.runtime.net.mail;

import java.io.UnsupportedEncodingException;
import java.net.IDN;
import java.util.ArrayList;
import java.util.Iterator;

import jakarta.mail.internet.AddressException;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeUtility;

import lucee.commons.lang.StringUtil;
import lucee.runtime.exp.PageException;
import lucee.runtime.op.Caster;
import lucee.runtime.op.Decision;
import lucee.runtime.type.Array;
import lucee.runtime.type.Struct;
import lucee.runtime.type.util.ListUtil;

public final class MailUtil {

	public static String encode(String text,String encoding) throws UnsupportedEncodingException {
		//print.ln(StringUtil.changeCharset(text,encoding));
		return MimeUtility.encodeText(text,encoding,"Q");
	}
	
	public static String decode(String text) throws UnsupportedEncodingException {
		return MimeUtility.decodeText(text);
	}



    public static InternetAddress toInternetAddress(Object emails) throws MailException, UnsupportedEncodingException, PageException {

        if ( emails instanceof String )
            return parseEmail( emails );

        InternetAddress[] addresses = toInternetAddresses( emails );
        if ( addresses != null && addresses.length > 0 )
            return addresses[0];

        return null;
    }


    public static InternetAddress[] toInternetAddresses(Object emails) throws MailException, UnsupportedEncodingException, PageException {

        if (emails instanceof String )
            return fromList((String) emails);
        
        else if ( Decision.isArray(emails) ) 
            return fromArray(Caster.toArray(emails));
        
        else if ( Decision.isStruct(emails) ) 
            return new InternetAddress[]{ fromStruct(Caster.toStruct(emails)) };
        
        else
            throw new MailException("e-mail defintions must be one of the following types [string,array,struct], not ["+emails.getClass().getName()+"]");
    }


    private static InternetAddress[] fromArray(Array array) throws MailException, PageException, UnsupportedEncodingException {

        Iterator it = array.valueIterator();
        Object el;
        ArrayList<InternetAddress> pairs = new ArrayList();

        while(it.hasNext()){
            el=it.next();
            if ( Decision.isStruct( el ) ) {

                pairs.add( fromStruct(Caster.toStruct(el)) );
            }
            else {

                InternetAddress addr = parseEmail( Caster.toString(el) );
                if ( addr != null )
                    pairs.add( addr );
            }
        }

        return pairs.toArray( new InternetAddress[ pairs.size() ] );
    }


    private static InternetAddress fromStruct( Struct sct ) throws MailException, UnsupportedEncodingException {

        String name = Caster.toString(sct.get("label",null),null);
        if ( name == null )
            name=Caster.toString(sct.get("name",null),null);

        String email = Caster.toString(sct.get("email",null),null);
        if ( email == null )
            email = Caster.toString(sct.get("e-mail",null),null);
        if ( email == null )
            email = Caster.toString(sct.get("mail",null),null);

        if( StringUtil.isEmpty(email) )
            throw new MailException("missing e-mail definition in struct");

        if(name==null) name="";

        return new InternetAddress( email, name );
    }


    private static InternetAddress[] fromList( String strEmails ) {

        if ( StringUtil.isEmpty( strEmails, true ) )
            return new InternetAddress[0];

        Array raw = ListUtil.listWithQuotesToArray(strEmails, ",;", "\"");

        Iterator<Object> it = raw.valueIterator();
        ArrayList<InternetAddress> al = new ArrayList();

        while( it.hasNext() ) {

            InternetAddress addr = parseEmail( it.next() );

            if( addr != null )
                al.add( addr );
        }

        return al.toArray( new InternetAddress[ al.size() ] );
    }


    /**
     * returns true if the passed value is a in valid email address format
     * @param value
     * @return
     */
    public static boolean isValidEmail( Object value ) {

        InternetAddress addr = parseEmail( value );

        if ( addr != null ) {

	        String address = addr.getAddress();

	        if ( address.contains( ".." ) )
		        return false;

	        int pos = address.indexOf( '@' );

	        if ( pos < 1 || pos == address.length() - 1 )
		        return false;

	        String local  = address.substring(0, pos);
	        String domain = address.substring(pos + 1);

	        if ( domain.charAt( 0 ) == '.'
			  || local.charAt(  0 ) == '.'
			  || local.charAt( local.length() - 1 ) == '.' )
		        return false;

	        pos = domain.lastIndexOf( '.' );

	        if ( pos > 0 && pos < domain.length() - 2 )         // test TLD to be at least 2 chars all alpha characters
	            return StringUtil.isAllAlpha( domain.substring( pos + 1 ) );
        }

        return false;
    }


    /**
     * returns an InternetAddress object or null if the parsing fails.  to be be used in multiple places.
     * @param value
     * @return
     */
    public static InternetAddress parseEmail( Object value ) {

        String str = Caster.toString( value, "" );

        if ( str.indexOf( '@' ) > -1 ) {

            try {

                InternetAddress addr = new InternetAddress( str );

                fixIDN( addr );
                return addr;
            }
            catch ( AddressException ex ) {}
        }

        return null;
    }


    /**
     * converts IDN to ASCII if needed
     * @param addr
     */
    public static void fixIDN( InternetAddress addr ) {

        String address = addr.getAddress();
        int pos = address.indexOf( '@' );

        if ( pos > 0 && pos < address.length() - 1 ) {

            String domain = address.substring( pos + 1 );

            if ( !StringUtil.isAscii( domain ) ) {

                domain = IDN.toASCII( domain );
                addr.setAddress( address.substring( 0, pos ) + "@" + domain );
            }
        }
    }

}
