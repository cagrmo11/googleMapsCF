<cfoutput>
<div id="maplegend" style="padding:0 0 10px 0;margin: 0 0 0 15px;"></div>
<div id="countryMap" style="margin:0 ;width:778px;height:500px;border:1px solid grey;margin: 0 0 15px 10px;"></div>
<div id="countryMap2" style="margin:0 ;width:180px;height:200px;border:1px solid grey;margin: 0 20px 15px 5px;float:right;"></div>

//Defines variables including script location and language
<script type="text/javascript">
    var _map;
    var _icon;
    var theBounds;
    var myself = "#myself#";
    var backText = "#lang.f_back#";
    var districtText = "#lang.f_selectDistrictOnMap#";
    var cityText = "#lang.f_selectCityOnMap#";
    var property = "#lang.f_property#";
    var properties = "#lang.f_properties#";
    var listingText = "#lang.f_seeTheListings#";
    var overMap = "#lang.f_overTheMap#";
    var inList = "#lang.f_inList#";
    var mapSearch = "#lang.f_mapSearch#";
    var departmentText = "#lang.f_selectDepartmentOnMap#";
  	var _cfscriptLocation = "#variables.basehref#_model/components/ajaxFunctions.cfc";	
</script>
</cfoutput>
