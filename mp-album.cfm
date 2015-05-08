<cfsetting enableCFoutputOnly="true">
	<!--- store the picasa username variable --->
	<cfset VARIABLES.username = 'picasateam'>
	<!--- connect to the picasaCFC codebase --->
	<cfset VARIABLES.picasaCFC = createObject("component", "picasaCFC").init(VARIABLES.username)>
	<!--- get a listing of all photos in this album --->
	<cfset VARIABLES.photoList = VARIABLES.picasaCFC.getAlbum(URL.rsslink)>
<cfsetting enableCFoutputOnly="false">

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
<head>
	<title> picasaCFC - ColdFusion based RSS reader for Picasa Web Albums </title>
	<link href="mp-styles.css" rel="stylesheet" type="text/css" />
	<link href="thickbox.css" rel="stylesheet" type="text/css" />
	<script language="javascript" src="http://code.jquery.com/jquery-latest.pack.js" type="text/javascript"></script>
	<script language="javascript" src="thickbox-compressed.js" type="text/javascript"></script>
</head>
<body>

<cfoutput>
<div id="albumContainer">
	<cfloop index="p" from="1" to="#ArrayLen(VARIABLES.photoList)#">
		<table>
		<tr valign="top">
			<td><a href="#VARIABLES.photoList[p]['large']#" class="thickbox"><img src="#VARIABLES.photoList[p]['photo']#" alt="#VARIABLES.photoList[p]['caption']#"/></a></td>
			<td>
				<p><b>Name: </b> #VARIABLES.photoList[p]['caption']#</p>
				<p><b>Date: </b> #VARIABLES.photoList[p]['date']#</p>
			</td>
		</tr>
		</table>

		<!--- <div class="photo">
			<a href="#VARIABLES.photoList[p]['large']#" title="#VARIABLES.photoList[p]['caption']#" class="thickbox"><img src="#VARIABLES.photoList[p]['photo']#" alt="#VARIABLES.photoList[p]['caption']#"></a>
			<div>#VARIABLES.photoList[p]['caption']#</div>
		</div> --->
	</cfloop>
</div>
</cfoutput>

</body>
</html>