@stateCode varchar(4)
AS
BEGIN
  SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	select
		c.cityCode
	,	c.cityName
	,	c.latRad * 57.2957795 as lat
	,	c.lonRad * 57.2957795 as lon
	,	count(p.propertyCode) as propCnt
	from tbl_cities c 
	left join tbl_properties p on p.fakeCityCode = c.cityCode and p.status <> 'D'
	--left join tbl_companies co on co.agencyCode = p.agencyCode 
	left join tbl_states s on s.stateCode = c.stateCode
	left join tbl_regions r on r.regionCode = s.regionCode
	where
		s.stateCode = @stateCode
	and c.latRad <> 0
	and c.lonRad <> 0
	and p.status ='A'
	group by c.cityCode, c.cityName, c.latRad, c.lonRad
	having count(p.propertyCode) > 0
	order by c.cityname

END
