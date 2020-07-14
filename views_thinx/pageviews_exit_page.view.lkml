view: pageviews_exit_page {
  view_label: "Pageviews"
  derived_table: {
     datagroup_trigger: heap_refresh
     distribution: "session_id"
     sortkeys: ["time"]
#     explore_source: pageviews {
#       column: event_id {}
#       column: session_id {}
#       column: full_path {}
#       column: pageview_reverse_order {}
#     }
    sql:
    SELECT event_id, session_id, "time", full_path
    FROM (
      SELECT
      pageviews.event_id  AS event_id,
      pageviews.session_id as session_id,
      pageviews.time as "time",
      pageviews.domain || (lower(pageviews.path))  AS full_path,
      ROW_NUMBER() OVER (PARTITION BY pageviews.session_id || '|' || pageviews.user_id ORDER BY pageviews.time DESC )  AS pageview_reverse_order
      FROM ${pageviews_dedupe.SQL_TABLE_NAME}  AS pageviews
    ) as exit_row
    WHERE pageview_reverse_order = 1
    ;;
  }
  dimension: event_id {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.event_id ;;
  }
  dimension: session_id {
    hidden: yes
    type: string
    sql: ${TABLE}.session_id ;;
  }
  dimension: exit_page {
    type: string
    sql: ${TABLE}.full_path ;;
  }
}
