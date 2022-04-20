with locs as
         (select DISTINCT REPLACE(loc, ' ', '-') as loc
          from harvested_record hr
                   join loc l on hr.id = l.harvested_record_id
          where import_conf_id = 100001
          UNION
          select DISTINCT REPLACE(loc, ' ', '') as loc
          from harvested_record hr
                   join loc l on hr.id = l.harvested_record_id
          where import_conf_id = 100001
          UNION
          select DISTINCT loc
          from harvested_record hr
                   join loc l on hr.id = l.harvested_record_id
          where import_conf_id = 100001),
     locs_others as (select DISTINCT loc
                     from harvested_record hr
                              join loc l on hr.id = l.harvested_record_id
                     where import_conf_id != 100001)
select DISTINCT loc
from locs_others
where loc not in (select loc from locs)
