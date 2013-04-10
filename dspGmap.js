var map, map2;
var mainArray = [];
var windows = [];
function initialize() {
    var latlng = new google.maps.LatLng(46.199,5.21666);
    var latlng2 = new google.maps.LatLng(21.1144,55.5325);
	
	var mapOptions = {
		center: latlng,
		mapTypeId: google.maps.MapTypeId.ROADMAP,
		mapTypeControl:true,
		navigationControlOptions: {style: google.maps.NavigationControlStyle.SMALL}
	};
	
	var mapOptions2 = {
		center: latlng2,
		mapTypeId: google.maps.MapTypeId.ROADMAP,
		mapTypeControl:true,
		navigationControlOptions: {style: google.maps.NavigationControlStyle.SMALL}
	};
	
	map = new google.maps.Map(document.getElementById("countryMap"),mapOptions);
	
	map2 = new google.maps.Map(document.getElementById("countryMap2"),mapOptions2);
  loadStates();
}

function loadStates(){
    DWREngine._execute(_cfscriptLocation,null,'getMapStates',loadStatesResult);
}

function loadStatesResult(result){
  theBounds = new google.maps.LatLngBounds();
  for (i=0;i<result.length;i++){
    text = listingText.replace("@@props", result[i].PROPCNT);
    infoHTML = "<div id='infoWindow' style='text-align:left;'>" +
      "<strong>" + result[i].STATENAME + " (" + result[i].STATECODE + ")</strong>" +
      "<div class='clearAll'><span id='listTitle'>" + text + "</span><ul>" + 
      "<li><a href='javascript:getCities(" + result[i].STATECODE + ");'>" + overMap + "</a></li>" +
      "<li><a href='" + myself + "csearch.getPropertyList&stateCode=" + result[i].STATECODE + "'>" + inList + "</a></li></ul></div></div>";
    tmp = new google.maps.LatLng(result[i].LAT,result[i].LON);
    theBounds.extend(tmp);
    createMarker(tmp,result[i].STATECODE, '', infoHTML);
  }
  document.getElementById("maplegend").innerHTML = "<br /><span style='color:#3e3e3e;font-size:14pt;'>" + mapSearch + "</span> - <span style='color:#3e3e3e;font-size:11pt;'>" + departmentText + "</span><br/>";
  map.setCenter(theBounds.getCenter());
  map.fitBounds(theBounds);
  
  map2.setCenter(theBounds.getCenter());
  map2.fitBounds(theBounds);
}

function createMarker(coords, stateCode, cityCode, infoHTML) {
  var marker;
  var icon;
  var numberedIcon;
  var shadow;
  if (cityCode && cityCode.length > 0) {
    icon = new google.maps.MarkerImage("assets/images/mapIcons/mapIconLogo.png");
	shadow = new google.maps.MarkerImage('assets/images/mapIcons/mapIconShadow.png');
	var marker = new google.maps.Marker({
		position: coords,
		map: map,
		shadow: shadow,
		icon: icon,
		title: cityCode
	});
	
	var marker2 = new google.maps.Marker({
		position: coords,
		map: map2,
		shadow: shadow,
		icon: icon,
		title: cityCode
	});
    var infoWindow = new google.maps.InfoWindow({
		content: infoHTML,
		position: coords
	});
	google.maps.event.addListener(marker, 'click', function() {
		infoWindow.open(map,marker);
	});
	mainArray.push(marker);
	windows.push(infoWindow);	
	
  } else if(stateCode && stateCode.length >0) {
  	leftPx = stateCode.charAt(0)*18;
	topPx = stateCode.charAt(1)*18;
  	numberedIcon = new google.maps.MarkerImage('assets/images/mapIcons/mapIconSprite.png',
		new google.maps.Size(17,17),
		new google.maps.Point(leftPx,topPx),
		new google.maps.Point(0,17));
	shadow = new google.maps.MarkerImage('assets/images/mapIcons/mapIconSprite.png',
		new google.maps.Size(24,17),
		new google.maps.Point(0,178),
		new google.maps.Point(0,17));
	var marker = new google.maps.Marker({
		position: coords,
		map: map,
		shadow: shadow,
		icon: numberedIcon,
		title: stateCode
	});
	
	var marker2 = new google.maps.Marker({
		position: coords,
		map: map2,
		shadow: shadow,
		icon: numberedIcon,
		title: stateCode
	});
    var infoWindow = new google.maps.InfoWindow({
		content: infoHTML,
		position: coords
	});
	google.maps.event.addListener(marker, 'click', function() {
		infoWindow.open(map,marker);
	});
	mainArray.push(marker);
	windows.push(infoWindow);	
  }
}
function clearWindows(){
	if (windows){
		for(i=0;i<windows.length;i++){
			windows[i].close();
		}
	}		
}

function clearArr(array){
	if (array) {
  		for (i=0;i<array.length;i++) {
    		array[i].setMap(null);
  		}
	}
}
function right(str, n)
{
      if (n <= 0)
          return "";
      else if (n > String(str).length)
          return str;
      else
   {
          var iLen = String(str).length;
          return String(str).substring(iLen, iLen - n);
      }
} 

function getCities(stateCode){
  stateCode = right('00'+ stateCode, 2);
  DWREngine._execute(_cfscriptLocation,null,'getPropCountPerCity',stateCode,"",getCitiesResult);
}

function getCitiesResult(result){
	var cityBounds = new google.maps.LatLngBounds();
	clearArr(mainArray);
	clearWindows();
	for (i = 0; i < result.length; i++) {
		if (result[i].LAT.length > 0 && Math.abs(result[i].LAT) > 0 && result[i].LON.length > 0 && Math.abs(result[i].LON) > 0) {
			tmp = new google.maps.LatLng(result[i].LAT, result[i].LON);
			cityBounds.extend(tmp);
			if (result[i].PROPCNT > 0) {
				infoHTML = "<div id='infoWindow'><div id='city'><a href='index.cfm?fuseaction=csearch.getPropertyList&cityCodeList=" + result[i].CITYCODE + " '>" + result[i].CITYNAME + "</a></div><div id='properties'><a href='index.cfm?fuseaction=csearch.getPropertyList&cityCodeList=" + result[i].CITYCODE + " '>" + result[i].PROPCNT + (result[i].PROPCNT > 1 ? ' Biens' : ' Bien') + "</a></div></div>";
				createMarker(tmp, '', result[i].CITYCODE, infoHTML);
			}
		}
		
	}
	map.setCenter(cityBounds.getCenter());
	map.fitBounds(cityBounds);
	
	map2.setCenter(cityBounds.getCenter());
	map2.fitBounds(cityBounds);
	if (result.length > 0 && result[i-1].CITYNAME.indexOf("Paris")>-1) {
    	document.getElementById("maplegend").innerHTML = "<span style='color:darkgrey;font-size:14pt;'>" + districtText + "</span><br/><a href='javascript:initialize();' style='color:red;text-decoration:none;font-size:10pt;'>" + backText + "</a>";
  	} else document.getElementById("maplegend").innerHTML = "<span style='color:darkgrey;font-size:14pt;'>" + cityText + "</span><br/><a href='javascript:initialize();' style='color:red;text-decoration:none;font-size:10pt;'>" + backText + "</a>";
}
setTimeout('initialize()',500);
