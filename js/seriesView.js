// Generated by CoffeeScript 1.8.0
var $sDescr, $sImages, $sTitles, CLASS_T_BTN, CLASS_VIEW_FULL, DEFAULT_SERIES, DIVIDER_CHAR, FADE_SPEED, ID_CURR_SERIES_BTN, ID_IMAGES, ID_SERIES_DESCRIPTION, ID_TITLES, S_TITLE_COLOR_CURR, S_TITLE_COLOR_OTHR, currSeriesIndex, fadeComplete, getIndex, i, setSeries, _i, _ref;

DIVIDER_CHAR = '|';

S_TITLE_COLOR_CURR = '';

S_TITLE_COLOR_OTHR = '';

DEFAULT_SERIES = 0;

ID_TITLES = "#seriesTitles";

ID_IMAGES = "#seriesImages";

ID_CURR_SERIES_BTN = "currentSeriesBtn";

ID_SERIES_DESCRIPTION = "#seriesDescription";

CLASS_VIEW_FULL = "viewFull";

CLASS_T_BTN = "seriesTitleBtn";

FADE_SPEED = 200;

$sTitles = $(ID_TITLES);

$sImages = $(ID_IMAGES);

$sDescr = $(ID_SERIES_DESCRIPTION);

fadeComplete = false;

currSeriesIndex = 0;

getIndex = function(element) {
  var index;
  index = $("." + CLASS_T_BTN).index(element);
  return index;
};

setSeries = function(index) {
  var imageCode, img, _i, _len, _ref, _ref1;
  $sImages.fadeIn(FADE_SPEED);
  $sDescr.fadeIn(FADE_SPEED);
  imageCode = "";
  $("#" + ID_CURR_SERIES_BTN).removeAttr("id");
  $(ID_TITLES + " :eq(" + index + ")").attr("id", ID_CURR_SERIES_BTN + "");
  $sDescr.empty();
  if (seriesData[index].description !== "") {
    $sDescr.append("<h3>" + seriesData[index].description + "</h3>");
  }
  $sImages.empty();
  _ref = seriesData[index].images;
  for (_i = 0, _len = _ref.length; _i < _len; _i++) {
    img = _ref[_i];
    imageCode += "<article class='6u 12u$(3) work-item'><a href='" + img.href + "' class='image fit thumb'><img src='" + img.src + "' alt='" + img.alt + "' /></a><h3>" + img.title + "</h3><p>" + img.description + "</p><a class='" + CLASS_VIEW_FULL + "' href='" + img.href + "' data-poptrox='ignore'>View Full Image</a></article>";
    $sImages.append(imageCode);
    imageCode = "";
  }
  $('#two').poptrox({
    caption: function($a) {
      return $a.next('h3').text();
    },
    overlayColor: '#2c2c2c',
    overlayOpacity: 0.85,
    popupCloserText: '',
    popupLoaderText: '',
    selector: '.work-item a.image.fit.thumb',
    usePopupCaption: true,
    usePopupDefaultStyling: false,
    usePopupEasyClose: false,
    usePopupNav: true,
    windowMargin: (_ref1 = skel.isActive('small')) != null ? _ref1 : {
      0: 50
    }
  });
  currSeriesIndex = index;
};

$sTitles.empty();

$sImages.empty();

for (i = _i = 0, _ref = seriesData.length; _i < _ref; i = _i += 1) {
  $sTitles.append("<span class=" + CLASS_T_BTN + ">" + seriesData[i].title + "</span>");
  if ((i + 1) !== seriesData.length) {
    $sTitles.append(' ' + DIVIDER_CHAR + ' ');
  }
}

setSeries(DEFAULT_SERIES);

$("." + CLASS_T_BTN).click(function() {
  var newIndex;
  newIndex = getIndex($(this));
  if (newIndex !== currSeriesIndex) {
    $sDescr.fadeOut(FADE_SPEED);
    $sImages.fadeOut(FADE_SPEED, function() {
      return setSeries(newIndex);
    });
  }
});
