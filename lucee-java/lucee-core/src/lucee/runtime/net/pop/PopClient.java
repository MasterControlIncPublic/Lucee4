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
package lucee.runtime.net.pop;

import jakarta.mail.Folder;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;

import lucee.runtime.net.mail.MailClient;

import com.sun.mail.pop3.POP3Folder;

public final class PopClient extends MailClient {

	public PopClient(String server, int port, String username, String password, boolean secure) {
		super(server, port, username, password, secure);
	}

	protected String getId(Folder folder,Message message) throws MessagingException {
		return ((POP3Folder)folder).getUID(message);
	}

	protected String getTypeAsString() {
		return "pop3";
	}

	protected int getType() {
		return TYPE_POP3;
	}
	
}