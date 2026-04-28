<!--- 
 *
 * Copyright (c) 2014, the Railo Company LLC. All rights reserved.
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
 ---><cfcomponent extends="org.lucee.cfml.test.LuceeTestCase">
	<!---
	<cffunction name="beforeTests"></cffunction>
	<cffunction name="afterTests"></cffunction>
	<cffunction name="setUp"></cffunction>
	--->
	<cffunction name="testExpandPath" localMode="modern">

<!--- begin old test code --->
<cfset dir=getDirectoryFromPath(GetBaseTemplatePath())>
<cfset dir=mid(dir,1,len(dir)-1)>

<cfset parent=getDirectoryFromPath(dir)>
<cfset parent=mid(parent,1,len(parent)-1)>

<cfset valueEquals(left="#ExpandPath(".")#" ,right="#dir#")>

<cfset valueEquals(
	left="#ExpandPath("..")#" ,
	right="#parent#")>
<cfset valueEquals(
	left="#ExpandPath("../")#" ,
	right="#parent#/")>
	
<cfset valueEquals(
	left="#ExpandPath("../tags")#" ,
	right="#parent#/tags")>
		
		
<cfset valueEquals(
	left="#ExpandPath("../tagx/")#" ,
	right="#parent#/tagx/")>
<cfset valueEquals(
	left="#ExpandPath("/jm")#" ,
	right="#server.coldfusion.rootdir#/jm")>
 
<cfset valueEquals(
	left="#ExpandPath("\jm")#" ,
	right="#server.coldfusion.rootdir#/jm")>

<cfset valueEquals(
	left="#ExpandPath("\lucee\")#" ,
		right="#server.coldfusion.rootdir#/WEB-INF/lucee/context/")>
<cfset valueEquals(
	left="#ExpandPath("\lucee")#" ,
		right="#server.coldfusion.rootdir#/WEB-INF/lucee/context")>

<!--- end old test code --->

		<!---
			Linux cross-platform fix: web-root-relative paths must always resolve against
			the web root, not the Linux filesystem root. On Linux, /foo is an absolute path
			so the old code returned /foo literally instead of <webroot>/foo.
		--->

		<!--- /prefixed path must resolve to webroot, not bare Linux filesystem root --->
		<cfset local.result = ExpandPath("/linux_compat_nonexistent_dir")>
		<cfset assertTrue(
			left(local.result, len(server.coldfusion.rootdir)) eq server.coldfusion.rootdir,
			"ExpandPath('/...') must start with web root, not a bare Linux path. Got: #local.result#")>

		<!--- backslash path must also resolve to webroot after normalization --->
		<cfset local.result = ExpandPath("\linux_compat_nonexistent_dir")>
		<cfset assertTrue(
			left(local.result, len(server.coldfusion.rootdir)) eq server.coldfusion.rootdir,
			"ExpandPath('\...') must start with web root after backslash normalization. Got: #local.result#")>

		<!--- .. segments in web-root-relative paths must be normalized --->
		<cfset valueEquals(
			left="#ExpandPath("/linux_compat_a/../linux_compat_b")#",
			right="#server.coldfusion.rootdir#/linux_compat_b")>

		<!--- <cfset assertEquals("","")> --->
	</cffunction>
	
	<cffunction access="private" name="valueEquals">
		<cfargument name="left">
		<cfargument name="right">
		<cfset assertEquals(arguments.right,arguments.left)>
	</cffunction>
</cfcomponent>