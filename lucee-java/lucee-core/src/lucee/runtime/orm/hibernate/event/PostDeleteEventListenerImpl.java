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
package lucee.runtime.orm.hibernate.event;

import lucee.runtime.Component;
import lucee.runtime.orm.hibernate.CommonUtil;

import org.luceehibernate.event.PostDeleteEvent;
import org.luceehibernate.event.PostDeleteEventListener;

public class PostDeleteEventListenerImpl extends EventListener implements PostDeleteEventListener {

	private static final long serialVersionUID = -4882488527866603549L;

	public PostDeleteEventListenerImpl(Component component) {
	    super(component, CommonUtil.POST_DELETE, false);
	}

	public void onPostDelete(PostDeleteEvent event) {
    	invoke(CommonUtil.POST_DELETE, event.getEntity());
    }

}
