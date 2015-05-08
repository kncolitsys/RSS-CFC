<cfcomponent name="cfPicasa" output="false" access="remote">

	<!--- Picasa User Information --->
	<cfset VARIABLES.user = "picasateam">
	<cfset VARIABLES.picsize.array = '32,48,64,72,144,160,200,288,320,400,512,576,640,720,800'>
	<cfset VARIABLES.picsize.gallery = 72>
	<cfset VARIABLES.picsize.album = 288>
	<cfset VARIABLES.picsize.large = 800>
	<cfset VARIABLES.picsize.cropgallerythumb = '-c'>
	<cfset VARIABLES.picsize.cropphotothumb = ''>

	<!--- Picasa RSS Information --->
	<cfset VARIABLES.picasaURL = StructNew()>
	<cfset VARIABLES.picasaURL.gURL = "http://picasaweb.google.com/data/feed/base/user/~USERNAME~?kind=album&alt=rss&hl=en_US&access=public">
	<cfset VARIABLES.picasaURL.gallery = "">

	<cffunction name="init" access="public" returntype="picasaCFC" output="false">
		<cfargument name="username" type="string" required="true">
		<cfargument name="gallerysize" type="numeric" required="false">
		<cfargument name="albumsize" type="numeric" required="false">
		<cfargument name="largesize" type="numeric" required="false">
		<cfargument name="cropgallerythumb" type="string" required="false">
		<cfargument name="cropphotothumb" type="string" required="false">

		<cfif ARGUMENTS.username IS ''>
			<cfoutput>Username cannot be blank.</cfoutput><cfabort>
		<cfelse>
			<cfset VARIABLES.user = ARGUMENTS.username>
		</cfif>

		<cfif IsDefined('ARGUMENTS.gallerysize') AND ARGUMENTS.gallerysize IS NOT ''>
			<cfset VARIABLES.picsize.gallery = forceValue(ARGUMENTS.gallerysize)>
		</cfif>
		<cfif IsDefined('ARGUMENTS.albumsize') AND ARGUMENTS.albumsize IS NOT ''>
			<cfset VARIABLES.picsize.album = forceValue(ARGUMENTS.albumsize)>
		</cfif>
		<cfif IsDefined('ARGUMENTS.largesize') AND ARGUMENTS.largesize IS NOT ''>
			<cfset VARIABLES.picsize.large = forceValue(ARGUMENTS.largesize)>
		</cfif>
		<cfif IsDefined('ARGUMENTS.cropgallerythumb') AND ARGUMENTS.cropgallerythumb IS NOT '' AND ARGUMENTS.cropgallerythumb IS true AND VARIABLES.picsize.gallery LTE 160>
			<cfset VARIABLES.picsize.cropgallerythumb = '-c'>
		</cfif>
		<cfif IsDefined('ARGUMENTS.cropphotothumb') AND ARGUMENTS.cropphotothumb IS NOT '' AND ARGUMENTS.cropphotothumb IS true AND VARIABLES.picsize.album LTE 160>
			<cfset VARIABLES.picsize.cropphotothumb = '-c'>
		</cfif>

		<cfreturn this>
	</cffunction>




	<!--- 
		Pure data methods. These methods return arrays of structures
	--->

	<cffunction name="getGalleries" access="public" returntype="array" output="false">

		<cfset var galleryList = ''>
		<cfset var string = ''>
		<cfset var galleries = []>
		<cfset var tmpThumbString = ''>

		<!--- RSS feed --->
		<cfset VARIABLES.picasaURL.gallery = ReplaceNoCase(VARIABLES.picasaURL.gURL,'~USERNAME~',VARIABLES.user)>
		<cffeed source="#VARIABLES.picasaURL.gallery#" query="galleryList">

		<!--- loop over the gallery list query, do some regex to extract final values --->
		<cfloop query="galleryList">
			<cfset galleries[currentrow] = {}>
			<cfset tmpThumbString = ListGetAt(REReplaceNoCase(galleryList.content,'src="(.*?)"','|\1|','ALL'),2,'|')>
			<cfset galleries[currentrow]['albumRSS'] = ToBase64(ReplaceNoCase(galleryList.id,'/entry/','/feed/','ALL'))>
			<cfset galleries[currentrow]['href'] = ListGetAt(REReplaceNoCase(galleryList.content,'href="(.*?)"','|\1|','ALL'),2,'|')>
			<cfset galleries[currentrow]['thumb'] = REReplace(tmpThumbString,'/s[0-9]{2,3}-c/','/s#VARIABLES.picsize.gallery##VARIABLES.picsize.cropgallerythumb#/')>
			<cfset galleries[currentrow]['name'] = ListGetAt(REReplaceNoCase(galleryList.content,'alt="(.*?)"','|\1|','ALL'),2,'|')>
			<cfset galleries[currentrow]['numPhotos'] = ListGetAt(REReplaceNoCase(galleryList.content,'">([0-9]{1,})</','|\1|','ALL'),2,'|')>
			<cfset galleries[currentrow]['date'] = ListGetAt(REReplaceNoCase(galleryList.content,'">([[:alpha:]]+ [0-9]+, [0-9]{4})</','|\1|','ALL'),2,'|')>
			<cfset galleries[currentrow]['content'] = galleryList.content>
		</cfloop>

		<cfreturn galleries>
	</cffunction>

	<cffunction name="getAlbum" access="public" returntype="array" output="false">
		<cfargument name="rsslink" required="true">

		<cfset var album = []>
		<cfset var tmpThumbString = ''>

		<cfset var feedSrc = ToString(ToBinary(ARGUMENTS.rsslink))>
		<cffeed source="#feedSrc#" query="photoList">

		<cfloop query="photoList">
			<cfset album[currentrow] = {}>
			<cfset tmpThumbString = ListGetAt(REReplaceNoCase(photoList.content,'src="(.*?)"','|\1|','ALL'),2,'|')>
			<cfset album[currentrow]['caption'] = photoList.title>
			<cfset album[currentrow]['href'] = ListGetAt(REReplaceNoCase(photoList.content,'href="(.*?)"','|\1|','ALL'),2,'|')>
			<cfset album[currentrow]['photo'] = REReplace(tmpThumbString,'/s[0-9]{2,3}/','/s#VARIABLES.picsize.album##VARIABLES.picsize.cropphotothumb#/')>
			<cfset album[currentrow]['large'] = REReplace(tmpThumbString,'/s[0-9]{2,3}/','/s#VARIABLES.picsize.large#/')>
			<cfset album[currentrow]['date'] = ListGetAt(REReplaceNoCase(photoList.content,'>([[:alpha:]]+ [0-9]+, [0-9]{4} [0-9]+:[0-9]+ [APM]+)<','|\1|','ALL'),2,'|')>
			<cfset album[currentrow]['content'] = photoList.content>
		</cfloop>

		<cfreturn album>
	</cffunction>




	<!--- 
		These methods return pure HTML
	--->

	<cffunction name="getAlbumHTML" access="remote" returnFormat="JSON" output="false">
		<cfargument name="rsslink" required="true">

		<cfset var album = getAlbum(URL.rsslink)>
		<cfset var albumHTML = ''>

		<cfsavecontent variable="albumHTML">
		<cfoutput>
			<cfloop index="p" from="1" to="#ArrayLen(album)#">
				<div class="photo">
					<a href="#album[p]['large']#" title="#album[p]['caption']#" class="thickbox"><img src="#album[p]['photo']#" alt="#album[p]['caption']#"></a>
					<div>#album[p]['caption']#</div>
				</div>
			</cfloop>
		</cfoutput>
		</cfsavecontent>

		<cfreturn REReplace(albumHTML,'[\n\r\t]','','ALL')>
	</cffunction>


	<!--- 
		For internal use
	--->

	<cffunction name="forceValue" access="private" returntype="string" output="false">
		<cfargument name="input" required="true" type="numeric">

		<cfset var num = 0>
		<cfset var finalNum = ListFirst(VARIABLES.picsize.array)>

		<cfloop list="#VARIABLES.picsize.array#" index="num">
			<cfif ARGUMENTS.input LT num>
				<cfbreak>
			</cfif>
			<cfset finalNum = num>
		</cfloop>

		<cfreturn finalNum>
	</cffunction>

</cfcomponent>