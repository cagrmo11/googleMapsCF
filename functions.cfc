<cffunction name="getMapStates" hint="type='keyvalue' jsreturn='array'">
    <cftry>
      <cfquery datasource="#application.mainDSN#" name="result" cachedWithin="#request.cacheTimeLong#">
	        exec dbo.getOneCityPerStateInRegion
	    </cfquery>
	    <cfreturn result />
	    
	    <cfcatch>
		    <cfset failure = cfcatch.message />
	        <cfreturn failure />
	    </cfcatch>
	</cftry>
</cffunction>

<cffunction name="getPropCountPerCity" hint="type='keyvalue' jsreturn='array'">
  <cfargument name="stateCode" type="any" required="true" />
	<cftry>
		<cfstoredproc procedure="dbo.getPropCountGroupByCity" datasource="#application.mainDSN#">
			<cfprocresult name="qCities" />
			<cfprocparam cfsqltype="CF_SQL_VARCHAR" type="in" value="#arguments.stateCode#" /> 
		</cfstoredproc>
	<cfcatch>
		
	</cfcatch>
	</cftry>
	<cfreturn qCities />
	<!--- returns: propCount, cityCode, cityName, lat, lon  --->
</cffunction>
