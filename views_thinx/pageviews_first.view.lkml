# If necessary, uncomment the line below to include explore_source.
# include: "heap_thinx.model.lkml"

# view: pageviews_first {
#   derived_table: {
#     explore_source: sessions {
#       column: session_id {field:pageviews.session_id}
#       column: session_date {field:pageviews.session_date}
#       column: query { field: pageviews.query }
#       column: path { field: pageviews.path }
#       derived_column: pageview_order {sql:row_number () over ( partition by session_id order by session_date);;}
#     bind_all_filters: yes
#     }

#   }
#   dimension: session_id {}
#   dimension: session_date {}
#   dimension: query {}
#   dimension: path {}
#   dimension: pageview_order {}

# }


view: pageviews_first {
  derived_table: {
    datagroup_trigger: heap_refresh
    distribution_style: all
    sortkeys: ["session_id"]
    sql: WITH pageviews_ranking as (
      Select session_id, session_time, row_number () over ( partition by session_id order by session_time) as session_page_order, path, query
      FROM heap_thinx.pageviews
      )
      Select session_id, session_time, session_page_order, path, query
       FROM pageviews_ranking
       where session_page_order = 1
       ;;
  }


  dimension: session_id {
    hidden: yes
    type: number
    sql: ${TABLE}.session_id ;;
  }

  dimension_group: session_time {
    hidden: yes
    type: time
    sql: ${TABLE}.session_time ;;
  }

  dimension: session_page_order {
    hidden: yes
    type: number
    sql: ${TABLE}.session_page_order ;;
  }

  dimension: first_path_of_session {
    alias: [path]
    type: string
    sql: ${TABLE}.path ;;
    link: {
      label: "Link to Path"
      url: "http://www.shethinx.com{{value}}"
    }
  }

  dimension: first_query_of_session {
    type: string
    sql: ${TABLE}.query ;;
  }

  set: detail {
    fields: [session_id, session_time_time, session_page_order, first_path_of_session, first_query_of_session]
  }
}
