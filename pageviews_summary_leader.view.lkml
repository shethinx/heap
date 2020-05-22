view: pageviews_summary_leader {
  derived_table: {
    publish_as_db_view: yes
    datagroup_trigger: heap_refresh
    distribution: "session_id"
    sortkeys: ["session_id"]
    explore_source: pageviews {
      column: session_id {}
      column: title {}
      column: count_of_pageviews {}
      filters: {
        field: pageviews.title
        value: "%Leaders%"
      }
    }
  }

  dimension: pk {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${session_id} || ${title} ;;
  }

  dimension: session_id {
    type: number
    sql: ${TABLE}.session ;;
  }

  dimension: title {
    type: string
    sql: ${TABLE}.title ;;
  }

  dimension: count_of_pageviews {
    type: number
    sql: ${TABLE}.count_of_pageviews ;;
  }

}
