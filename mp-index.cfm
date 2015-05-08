<cfsetting enableCFoutputOnly="true">
	<!--- store the picasa username variable --->
	<cfset VARIABLES.username = 'picasateam'>
	<!--- connect to the picasaCFC codebase --->
	<cfset VARIABLES.picasaCFC = createObject("component", "picasaCFC").init(VARIABLES.username)>
	<!--- get a listing of all galleries for this username --->
	<cfset VARIABLES.galleryList = VARIABLES.picasaCFC.getGalleries()>
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
	<div id="galContainer">
		<cfloop index="g" from="1" to="#ArrayLen(VARIABLES.galleryList)#">
			<table>
			<tr valign="top">
				<td>
					<a href="mp-album.cfm?rsslink=#VARIABLES.galleryList[g]['albumRSS']#"><img src="#VARIABLES.galleryList[g]['thumb']#" alt="#VARIABLES.galleryList[g]['name']#"/></a>
					<p><b>Name:</b> #VARIABLES.galleryList[g]['name']#</p>
					<p><b>Date:</b> #VARIABLES.galleryList[g]['date']#</p>
					<p><b>Total Photos:</b> #VARIABLES.galleryList[g]['numPhotos']#</p>
				</td>
			</tr>
			</table>
		</cfloop>
	</div>
</cfoutput>
</body>
</html>