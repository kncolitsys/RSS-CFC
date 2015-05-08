$(document).ready(function(){
	// store references to the album div
	var $album = $('#album');
	// when someone clicks a link inside one of the gallery listings
	$('.gallery a').each(function(){
		// store reference to the specific link
		var $gal = $(this);
		// get the href value for the specific link
		var href = $gal.attr('href');
		// load a click function on each a link inside a gallery container
		$gal.click(function(){
			// place a loading image inside the album container
			$album.html('').css({
				backgroundImage: 'url(loading.gif)',
				backgroundRepeat: 'no-repeat',
				backgroundPosition: 'center'
			});
			// initiate a call to the link in the anchor tag, we're expecting JSON data in response
			$.getJSON(href,function(data){
				// get rid of the loading image, dump the data into the album div
				$album.css({
					backgroundImage: ''
				}).html(data);
				// add mouseover effects to each photo container
				divOver();
				// loop over each anchor tag inside a photo container
				$('.photo a').each(function(){
					// store reference to the specific link
					var $pic = $(this);
					// get the href value
					var large = $pic.attr('href');
					// add click handler for each link
					$pic.click(function(){
						// open a thickbox window for this image
						tb_show('',large, '');
						// return false so the image doesn't load normally
						return false;
					});
				});
			});
			return false;
		});
	});

	// mouseover effects for photo containers
	function divOver() {
		$('#galleries .gallery, #album .photo').each(function(){
			$(this).hover(function(){
				$(this).css('backgroundColor','#eeeeee');
			},function(){
				$(this).css('backgroundColor','#ffffff');
			});
		});
	}

	// load the mouseover effect
	divOver();

});