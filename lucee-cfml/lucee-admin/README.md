## How to Build a Usable Admin Context For MasterControl

Intro: the Lucee admin page is loaded from the `lucee-context.lar` file inside of `<mastercontrol code location>\server\railo\lucee-server\context\context`. When a new EMS Service is created, this is copied into the installedServices folder for the corresponding service. In order to build the lucee-context.lar file, we need to go through some steps.

- Lucee needs a running Lucee instance in order to build its own lucee-context, so we'll use an existing MasterControl site
  1. Create a `test.cfm` file inside `<mastercontrol code location>\server\webapps\ROOT` (It doesn't NEED to be inside this folder, but for simplicity we'll just use it).
  2. Paste the following (and update it to match your site/code's info)
  ``` 
  <cfset url.admin_source = "<Lucee4 code location>\lucee-cfml\lucee-admin" />
  <cfset url.password = "<existing admin password>" />
  <cfinclude template="compileAdmin.cfm"/>
  ```
  3. Copy `<Lucee4 code location>\lucee-cfml\compileAdmin.cfm` to your `<mastercontrol code location>\server\webapps\ROOT` directory.
  4. In your browser, navigate to `<mastercontrol url>/test.cfm`. This should build a `lucee-context.ra` file inside of `<Lucee4 code location>\lucee-cfml\lucee-admin`

- Now we need to add some other items to this `.ra` file that was generated
  1. Move the generated `.ra` file to another directory
  2. Rename the `lucee-context.ra` file to `lucee-context.zip`
  3. Extract the zip file into its own folder
  4. In another file explorer navigate to `server\railo\lucee-server\context\context`
  5. In that folder there is a file named `lucee-context.lar`, change its extension to `zip` and extract it.
  6. Within that unzip `lucee-context` folder is a `res` folder, copy the `css`, `img`, and `js` folders out of that folder and paste them into your extracted `lucee-context.ra's` its `res` folder from step 3.
  7. Zip all the contents of the now modified `lucee-context` folder into a new `lucee-context.zip` file. (Ensure you don't introduce any intermediate folders.)
  8. Rename the `lucee-context.zip` file to `lucee-context.lar`
  9. Move this `.lar` file into `<mastercontrol code location>\server\railo\lucee-server\context\context` (your MasterControl instance will need to be stopped)
  10. Copy this same `lucee-context.lar` file into the Lucee repository replacing the existing one at `lucee-java/lucee-core/src/resource/context/lucee-context.lar`
      * As far as we can tell, this file isn’t actually used, but it is pretty confusing when it is different from what is committed to MasterControl so this is a good idea.

- Test to make sure your changes are pulled in be going to `<mastercontrol url>/ems/lucee/admin/web.cfm`