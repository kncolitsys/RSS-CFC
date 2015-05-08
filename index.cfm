<!doctype html public "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
<head>
	<title> picasaCFC - ColdFusion based RSS reader for Picasa Web Albums </title>

	<style type="text/css">
	<!--

	/* set the page font formatting. */
	body, p, div, td {
		font-family: Trebuchet, verdana, sans-serif;
		font-size: 1em;
		color: #000000;
		text-align: center;
	}

	#container {
		position: relative;
		width: 630px;
		height: 517px;
		margin: 0 auto;
		border: 1px solid #000000;
		background: #dddddd;
		text-align: left;
	}

	#comment {
		font-size: .8em;
		margin: 10px 10px 0 10px;
		text-align: left;
	}

		#container h1 {
			margin: 10px 10px 0 10px ;
			font-size: 1.5em;
		}

		#mp, #sp {
			width: 46%;
			height: 200px;
			float: left;
			margin: 10px;
		}

			#mp *, #sp * {
				text-align: left;
			}

			#container div h2 {
				font-size: 1.2em;
			}

		#footer {
			margin: 0 auto;
			height: 18px;
			font-size: .8em;
		}

	-->
	</style>

</head>
<body>
<cfoutput>
	<div id="container">
		<h1>picasaCFC</h1>
		<div id="mp">
			<h2>Multi Page (standard method)</h2>
			<p>
				This version uses standard linking methods to load galleries and albums, with <a href="http://jquery.com/demo/thickbox" target="_blank">Thickbox</a> to load in the indivudual photos.
			</p>
			<p><a href="mp-index.cfm">View demo</a></p>
		</div>
		<div id="sp">
			<h2>Single Page (enhanced method)</h2>
			<p>
				This version uses the <a href="http://jquery.com" target="_blank">jQuery</a> library to load in albums via AJAX, and <a href="http://jquery.com/demo/thickbox" target="_blank">Thickbox</a> to load in the indivudual photos.
			</p>
			<p><a href="sp-index.cfm">View demo</a></p>
		</div>
		<div id="comment">
			Please note that this CFC library uses ColdFusion 8 specific methods.<br />
			<b>ColdFusion 8 is required</b>
			<br /><br />
			<a href="picasaCFC.zip">Download picasaCFC</a>.
		</div>
	</div>
	<div id="footer">&copy; #Year(Now())# <a href="http://www.commadelimited.com" target="_blank">commadelimited.com</a></div>
</cfoutput>
</body>
</html>