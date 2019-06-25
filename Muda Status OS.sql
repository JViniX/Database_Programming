
select * from smm 
inner join osm on osm.osm_serie = smm.smm_osm_serie and osm.osm_num = smm.smm_osm 
where 
smm_osm = '101026' and
smm_osm_serie = '116'

--update smm
set smm_sfat = 'A'
where 
smm_osm = '101026' and
smm_osm_serie = '116' and 
smm_sfat = 'P'
