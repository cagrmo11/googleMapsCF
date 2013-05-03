BEGIN
	SET NOCOUNT ON;
	with cte as (
		  select distinct c.zip
		from tbl_cities c WITH(READPAST)
		left join tbl_states s on s.stateCode = c.stateCode
		left join tbl_regions r on r.regionCode = s.regionCode
		left join tbl_properties p on p.citycode = c.cityCode and p.status <> 'D'
		where c.latRad IS NOT NULL AND c.lonRad IS NOT NULL
		and (c.zip like '%000' or c.zip like '%001' or c.zip like '%97460' 
			or c.zip like '%97140' 
			or c.zip like '%97136'
			or c.zip like '%97127'
			or c.zip like '%97160'
			or c.zip like '%97114') and
		(select count(propertyCode) from tbl_properties where stateCode = c.stateCode and isActive = 1) > 0
		group by c.zip
		having count(p.propertyCode) >= 0
	)
	select 
		zip
	,	case 
			when cte.zip = 97460 then '9706'
			when cte.zip = 97140 then '9705'
			when cte.zip = 97136 then '9704'
			when cte.zip = 97127 then '9703'
			when cte.zip = 97160 then '9702'
			when cte.zip = 97114 then '9701'
			else left(cte.zip, 2) end as stateCode
	,	case
			when cte.zip = 97460 then (select top 1 stateName from tbl_states where stateCode = '9706')
			when cte.zip = 97140 then (select top 1 stateName from tbl_states where stateCode = '9705')
			when cte.zip = 97136 then (select top 1 stateName from tbl_states where stateCode = '9704')
			when cte.zip = 97127 then (select top 1 stateName from tbl_states where stateCode = '9703')
			when cte.zip = 97160 then (select top 1 stateName from tbl_states where stateCode = '9702')
			when cte.zip = 97114 then (select top 1 stateName from tbl_states where stateCode = '9701')
			else (select top 1 stateName from tbl_states where (stateCode = left(cte.zip,2))) end as stateName
																	
	,	lat = (select top 1 latRad * 57.2957795 from tbl_cities where zip = cte.zip)
	,	lon = (select top 1 lonRad * 57.2957795 from tbl_cities where zip = cte.zip)
	,	propCnt = 
		(select count(p.propertyCode) 
		from tbl_properties p
		left join tbl_cities cit on cit.cityCode = p.fakeCityCode
		left join tbl_companies ag on ag.agencyCode = p.agencyCode
		where cit.stateCode = left(cte.zip,2) or cit.stateCode='9706' 
				or cit.stateCode = '9705' 
				or cit.stateCode='9704'
				or cit.stateCode='9703'
				or cit.stateCode='9702'
				or cit.stateCode='9701'
											  
		and ag.status is NULL
		and p.status <> 'D')
	from cte order by stateName
END
