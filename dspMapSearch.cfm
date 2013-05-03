<cfprocessingdirective pageencoding="utf-8" />
<cfoutput>
<div id="maplegend" style="padding:0 0 10px 0;margin: 0 0 0 15px;"></div>
<div id="maplegend2" style="padding:0 0 0px 0;margin: 48px 90px 0 0px;float:right;">
    <span style='color:darkgrey;font-size:14pt;'>Choisissez: </span><br/><br/>

	<a href="javascript:initialize();" style='color:##3e3e3e;font-size:11pt;'>France</a><br/> <br/>
	<span style='color:darkgrey;font-size:10pt;'>DOM-TOM</span><br/> 
	<ul style="margin:0 0 0 13px">
		<li><a href="javascript:initialize(2);" style='color:##3e3e3e;font-size:10pt;'>Réunion</a></li>
		<li><a href="javascript:initialize(3);" style='color:##3e3e3e;font-size:10pt;'>Guadeloupe</a></li>
	</ul>
</div>
<div id="countryMap" style="margin:0;width:775px;height:500px;border:1px solid grey;margin: 0 0 15px 10px;"></div>
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
    var reunion = "Reunion";
  	var _cfscriptLocation = "#variables.basehref#_model/components/ajaxFunctions.cfc";	
</script>
</cfoutput>
