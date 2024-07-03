## How to Build a Usable Admin Context For MasterControl

Intro: the Lucee admin page is loaded from the `lucee-context.lar` file inside of `<mastercontrol code location>\server\railo\lucee-server\context\context`. When a new EMS Service is created, this is copied into the installedServices folder for the corresponding service. In order to build the lucee-context.lar file, we need to go through some steps.

- Lucee needs a running Lucee instance in order to build its own lucee-context, so we'll use an existing MasterControl site
  1. Create a `test.cfm` file inside `<mastercontrol code location>\server\webapps\ROOT` (It doesn't NEED to be inside this folder, but for simplicity we'll just use it).
  2. Paste the following (and update it to match your stuff)
  ``` 
  <cfset url.admin_source = "<Lucee4 code location>\lucee-cfml\lucee-admin" />
  <cfset url.password = "<existing admin password>" />
  <cfinclude template="compileAdmin.cfm"/>
  ```
  3. Copy `<Lucee4 code location>\lucee-cfml\compileAdmin.cfm` to your `<mastercontrol code location>\server\webapps\ROOT` directory.
  4. In your browser, navigate to `<mastercontrol url>/test.cfm`. This should build a `lucee-context.ra` file inside of `<Lucee4 code location>\lucee-cfml\lucee-admin`

- Now we need to add some other items this `.ra` file it generated
  1. Move the generated `.ra` file to another directory
  2. Rename to `lucee-context.ra` file to `lucee-context.zip`
  3. Extract the zip file into its own folder
  4. Copy everything inside of `<Lucee4 code location>\lucee-cfml\lucee-admin` into the extracted `lucee-context` folder
  5. Zip all the contents of the `lucee-context` folder into a new `lucee-context.zip` file
  6. Rename the `lucee-context.zip` file to `lucee-context.lar`
  7. Move this `.lar` file into `<mastercontrol code location>\server\railo\lucee-server\context\context` (your MasterControl instance will need to be stopped)

- Test to make sure your changes are pulled in be going to `<mastercontrol url>/ems/lucee/admin/web.cfm`