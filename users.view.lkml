view: users {
  sql_table_name: heap_thinx.users ;;

  dimension: user_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.user_id ;;
  }

  dimension: identity {
    sql: ${TABLE}."identity" ;;
  }

  dimension_group: joindate {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.joindate ;;
  }

  dimension: pps_initial_referrer {
    type: string
    sql: ${TABLE}.pps_initial_referrer ;;
  }

  measure: count {
    hidden: yes
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [user_id, identity, sessions.count, joindate_date]
  }
}
