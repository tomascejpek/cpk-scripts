update harvested_record set next_dedup_flag=true where deleted is not null and next_dedup_flag is false and dedup_record_id in (select dedup_record_id from harvested_record where next_dedup_flag is true);
UPDATE harvested_record SET cluster_id = NULL, uuid = NULL, issn_series = NULL, issn_series_order = NULL, publication_year = NULL, scale = NULL, author_string = NULL, author_auth_key = NULL, raw_001_id = NULL, dedup_keys_hash = NULL, source_info_t = NULL, source_info_x = NULL, source_info_g = NULL, pages = NULL, weight = NULL, upv_application_id = NULL, sigla = NULL, raw_record=null, next_dedup_flag=true, next_biblio_linker_flag=true, next_biblio_linker_similar_flag=true,biblio_linker_keys_hash=null,bl_author=null,bl_publisher=null,bl_series=null,publisher=null,edition=null
where next_dedup_flag is true and deleted is not null and dedup_keys_hash is not null and dedup_keys_hash!='' and import_conf_id not in (316,400,344);
DELETE FROM title where harvested_record_id in (select id from harvested_record where deleted is not null and next_dedup_flag is true and import_conf_id not in (316,400,344));
DELETE FROM isbn where harvested_record_id in (select id from harvested_record where deleted is not null and next_dedup_flag is true and import_conf_id not in (316,400,344));
DELETE FROM issn where harvested_record_id in (select id from harvested_record where deleted is not null and next_dedup_flag is true and import_conf_id not in (316,400,344));
DELETE FROM ismn where harvested_record_id in (select id from harvested_record where deleted is not null and next_dedup_flag is true and import_conf_id not in (316,400,344));
DELETE FROM cnb where harvested_record_id in (select id from harvested_record where deleted is not null and next_dedup_flag is true and import_conf_id not in (316,400,344));
DELETE FROM language where harvested_record_id in (select id from harvested_record where deleted is not null and next_dedup_flag is true and import_conf_id not in (316,400,344));
DELETE FROM oclc where harvested_record_id in (select id from harvested_record where deleted is not null and next_dedup_flag is true and import_conf_id not in (316,400,344));
DELETE FROM ean where harvested_record_id in (select id from harvested_record where deleted is not null and next_dedup_flag is true and import_conf_id not in (316,400,344));
DELETE FROM short_title where harvested_record_id in (select id from harvested_record where deleted is not null and next_dedup_flag is true and import_conf_id not in (316,400,344));
DELETE FROM harvested_record_format_link where harvested_record_id in (select id from harvested_record where deleted is not null and next_dedup_flag is true and import_conf_id not in (316,400,344));
DELETE FROM bl_title where harvested_record_id in (select id from harvested_record where deleted is not null and next_dedup_flag is true and import_conf_id not in (316,400,344));
DELETE FROM bl_common_title where harvested_record_id in (select id from harvested_record where deleted is not null and next_dedup_flag is true and import_conf_id not in (316,400,344));
DELETE FROM bl_entity where harvested_record_id in (select id from harvested_record where deleted is not null and next_dedup_flag is true and import_conf_id not in (316,400,344));
DELETE FROM bl_topic_key where harvested_record_id in (select id from harvested_record where deleted is not null and next_dedup_flag is true and import_conf_id not in (316,400,344));
DELETE FROM bl_language where harvested_record_id in (select id from harvested_record where deleted is not null and next_dedup_flag is true and import_conf_id not in (316,400,344));
DELETE FROM anp_title where harvested_record_id in (select id from harvested_record where deleted is not null and next_dedup_flag is true and import_conf_id not in (316,400,344));
DELETE FROM uuid where harvested_record_id in (select id from harvested_record where deleted is not null and next_dedup_flag is true and import_conf_id not in (316,400,344));

select import_conf_id,count(*) from harvested_record where deleted is not null and dedup_keys_hash is not null and dedup_keys_hash!='' and import_conf_id not in (316,400,344) group by import_conf_id;
