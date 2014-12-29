# Handles switching from different series, as well as displaying them
# Created by Jared Bennett

# seriesData array is defined above in seriesData.js
# #seriesTitles is the div containing the title buttons
# #seriesImages is the div containing all the images 

# CONSTANTS #######################################################

DIVIDER_CHAR = '|' #'&#149;' 
S_TITLE_COLOR_CURR = ''
S_TITLE_COLOR_OTHR = ''
DEFAULT_SERIES = 0

ID_TITLES = "#seriesTitles"
ID_IMAGES = "#seriesImages"
ID_CURR_SERIES_BTN = "currentSeriesBtn"
ID_SERIES_DESCRIPTION = "#seriesDescription"
CLASS_VIEW_FULL = "viewFull"
CLASS_T_BTN = "seriesTitleBtn"


FADE_SPEED = 200

# GLOBALS ################################################################

$sTitles = $(ID_TITLES)
$sImages = $(ID_IMAGES)
$sDescr = $(ID_SERIES_DESCRIPTION)

fadeComplete = false
currSeriesIndex = 0

# FUNCTIONS #############################################################

# Retrieves the index of the element in it's container
getIndex = (element) ->
	index = $("." + CLASS_T_BTN).index(element)
	return index


# Changes thumbnails to the given series
setSeries = (index) ->
	$sImages.fadeIn(FADE_SPEED)
	$sDescr.fadeIn(FADE_SPEED)
	# console.log "switching to #" + index + ', ' + seriesData[index].title
	imageCode = ""
	
	#swap button
	$("#" + ID_CURR_SERIES_BTN).removeAttr("id")
	$(ID_TITLES + " :eq(" + index + ")").attr("id", ID_CURR_SERIES_BTN + "")
	
	# swap series description
	$sDescr.empty()	
	if seriesData[index].description != ""
		$sDescr.append("<h3>"+ seriesData[index].description + "</h3>")
	
	# swap images	
	$sImages.empty()
	for img in seriesData[index].images
		imageCode += "<article class='6u 12u$(3) work-item'><a href='" + 
			img.href + "' class='image fit thumb'><img src='" + img.src  +
			"' alt='" + img.alt + "' /></a><h3>" + img.title + "</h3><p>" + 
			img.description + "</p><a class='" + CLASS_VIEW_FULL + "' href='" + 
			img.href + "' data-poptrox='ignore'>View Full Image</a></article>"
				
		$sImages.append(imageCode)
		imageCode = ""
	
	#reload poptrox
	$('#two').poptrox
		caption: ($a) ->  return $a.next('h3').text(),
		overlayColor: '#2c2c2c',
		overlayOpacity: 0.85,
		popupCloserText: '',
		popupLoaderText: '',
		selector: '.work-item a.image.fit.thumb',
		usePopupCaption: true,
		usePopupDefaultStyling: false,
		usePopupEasyClose: false,
		usePopupNav: true,
		windowMargin: (skel.isActive('small') ? 0 : 50)
	
	currSeriesIndex = index
	
	return

# Example image Result:		
# <article class="6u 12u$(3) work-item">
# 	<a href="images/fulls/01.jpg" class="image fit thumb"><img src="images/thumbs/01.jpg" alt="" /></a>
# 	<h3>Magna sed consequat tempus</h3>
# 	<p>Lorem ipsum dolor sit amet nisl sed nullam feugiat.</p>
# </article>

# AUTO RUN ###############################################################

$sTitles.empty()
$sImages.empty()

# create the title buttons
for i in [0...seriesData.length] by 1
	# console.log 'SERIES ' + JSON.stringify(seriesData[i], null, 4)

	$sTitles.append "<span class=" + CLASS_T_BTN + ">" + seriesData[i].title + "</span>"
	
	if (i+1) != seriesData.length
		$sTitles.append(' ' + DIVIDER_CHAR + ' ')

setSeries(DEFAULT_SERIES)

##########################################################################

$("." + CLASS_T_BTN).click () ->
	newIndex = getIndex($(this)) 	
	if newIndex != currSeriesIndex
		$sDescr.fadeOut(FADE_SPEED)
		$sImages.fadeOut(FADE_SPEED, ()-> setSeries newIndex)
	return

