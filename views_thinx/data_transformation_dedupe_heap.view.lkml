
view: sessions_dedupe {
  derived_table: {
    datagroup_trigger: heap_refresh
    distribution: "session_id"
    sortkeys: ["time"]
    sql: SELECT *
    FROM (SELECT *, ROW_NUMBER () OVER ( PARTITION BY user_id, session_id) as row_number, NULLIF(SPLIT_PART(utm_content, '|', 4),'') as utm_content_part_4 FROM heap_thinx.sessions) as sessions
    WHERE sessions.row_number = 1;;
  }
}

view: pageviews_dedupe {
  derived_table: {
    datagroup_trigger: heap_refresh
    distribution: "session_id"
    sortkeys: ["time"]
    sql: SELECT *
          FROM (SELECT *, ROW_NUMBER () OVER ( PARTITION BY event_id) as row_number FROM heap_thinx.pageviews) as pageviews
          WHERE pageviews.row_number = 1;;
  }
}
