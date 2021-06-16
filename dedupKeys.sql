SELECT dedup_record_id                                               slouceny,
       ic.id_prefix,
       record_id,
       array_to_string(array_agg(DISTINCT c.cnb), ',')               cnb,
       array_to_string(array_agg(DISTINCT t.title), ',')             title,
       array_to_string(array_agg(DISTINCT st.short_title), ',')      short_title,
       array_to_string(array_agg(DISTINCT isb.isbn), ',')            isbn,
       array_to_string(array_agg(DISTINCT iss.issn), ',')            issn,
       array_to_string(array_agg(DISTINCT ismn.ismn), ',')           ismn,
       array_to_string(array_agg(DISTINCT o.oclc), ',')              oclc,
       array_to_string(array_agg(DISTINCT l.lang), ',')              lang,
       array_to_string(array_agg(DISTINCT hrf.name), ',')            format,
       array_to_string(array_agg(DISTINCT e.ean), ',')               ean,
       array_to_string(array_agg(DISTINCT pn.publisher_number), ',') publisher_number,
       array_to_string(array_agg(DISTINCT ct.title), ',')            bl_common_title,
       array_to_string(array_agg(DISTINCT ble.entity), ',')          bl_entity,
       array_to_string(array_agg(DISTINCT blt.title), ',')           bl_title,
       array_to_string(array_agg(DISTINCT bll.lang), ',')            bl_language,
       array_to_string(array_agg(DISTINCT bltk.topic_key), ',')      bl_topic_key,
       array_to_string(array_agg(DISTINCT anp.anp_title), ',')       anp_title,
       publication_year,
       author_string,
       author_auth_key,
       issn_series,
       uuid,
       cluster_id,
       pages,
       source_info_t,
       source_info_x,
       source_info_g,
       bl_author,
       bl_publisher,
       bl_series,
       publisher,
       edition
FROM harvested_record hr
         LEFT OUTER JOIN cnb c ON hr.id = c.harvested_record_id
         LEFT OUTER JOIN title t ON hr.id = t.harvested_record_id
         LEFT OUTER JOIN short_title st ON hr.id = st.harvested_record_id
         LEFT OUTER JOIN isbn isb ON hr.id = isb.harvested_record_id
         LEFT OUTER JOIN issn iss ON hr.id = iss.harvested_record_id
         LEFT OUTER JOIN ismn ismn ON hr.id = ismn.harvested_record_id
         LEFT OUTER JOIN oclc o ON hr.id = o.harvested_record_id
         LEFT OUTER JOIN language l ON hr.id = l.harvested_record_id
         LEFT OUTER JOIN harvested_record_format_link hrfl ON hr.id = hrfl.harvested_record_id
         LEFT OUTER JOIN harvested_record_format hrf ON hrfl.harvested_record_format_id = hrf.id
         LEFT OUTER JOIN import_conf ic ON hr.import_conf_id = ic.id
         LEFT OUTER JOIN ean e ON hr.id = e.harvested_record_id
         LEFT OUTER JOIN publisher_number pn ON hr.id = pn.harvested_record_id
         LEFT OUTER JOIN bl_common_title ct ON hr.id = ct.harvested_record_id
         LEFT OUTER JOIN bl_entity ble ON hr.id = ble.harvested_record_id
         LEFT OUTER JOIN bl_title blt ON hr.id = blt.harvested_record_id
         LEFT OUTER JOIN bl_language bll ON hr.id = bll.harvested_record_id
         LEFT OUTER JOIN bl_topic_key bltk ON hr.id = bltk.harvested_record_id
         LEFT OUTER JOIN anp_title anp ON hr.id = anp.harvested_record_id
WHERE hr.id = 1
GROUP BY hr.dedup_record_id, hr.record_id, hr.publication_year, hr.author_string, hr.author_auth_key, hr.issn_series,
         hr.uuid, hr.cluster_id, pages, ic.id_prefix, source_info_t, source_info_x, source_info_g, bl_author,
         bl_publisher, bl_series, publisher, edition
