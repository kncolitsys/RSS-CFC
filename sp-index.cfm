<cfsetting enableCFoutputOnly="true">
	<!--- store the picasa username variable --->
	<cfset VARIABLES.username = 'picasateam'>
	<!--- connect to the picasaCFC codebase --->
	<cfset VARIABLES.picasaCFC = createObject("component", "picasaCFC").init(VARIABLES.username)>
	<!--- get a listing of all galleries for this username --->
	<cfset VARIABLES.galleryList = VARIABLES.picasaCFC.getGalleries()>
<cfsetting enableCFoutputOnly="false">

<!doctype html public "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
<head>
	<title> picasaCFC - ColdFusion based RSS reader for Picasa Web Albums </title>
	<link href="sp-styles.css" rel="stylesheet" type="text/css" />
	<link href="thickbox.css" rel="stylesheet" type="text/css" />
	<script language="javascript" src="http://code.jquery.com/jquery-latest.pack.js" type="text/javascript"></script>
	<script language="javascript" src="thickbox-compressed.js" type="text/javascript"></script>
	<script language="javascript" src="sp-js.js" type="text/javascript"></script>
</head>
<body>
<cfoutput>
	<div id="container">
		<div id="galleries">
			<cfloop index="g" from="1" to="#ArrayLen(VARIABLES.galleryList)#">
				<div class="gallery">
					<a href="picasaCFC.cfc?method=getAlbumHTML&rsslink=#VARIABLES.galleryList[g]['albumRSS']#"><img src="#VARIABLES.galleryList[g]['thumb']#" alt="Display Gallery"></a>
					<div>
						<b>#VARIABLES.galleryList[g]['name']#</b><br />
						#VARIABLES.galleryList[g]['date']#<br />
						#VARIABLES.galleryList[g]['numPhotos']# photos
					</div>
				</div>
			</cfloop>
		</div>
		<div id="album"></div>
		<div id="footer">&copy; #Year(Now())# <a href="http://www.commadelimited.com" target="_blank">commadelimited.com</a></div>
	</div>
</cfoutput>
</body>
</html>