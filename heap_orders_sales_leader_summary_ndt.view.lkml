view: heap_orders_leader_sales_summary_ndt {

  #sql_table_name: looker_scratch.uc_thinx_heap_orders_leader_sales_summary_ndt ;;

  derived_table: {
    sql:
    SELECT leader_name, SUM(count) as count_of_orders
    FROM looker_scratch.uc_thinx_heap_orders_leader_sales_summary_ndt
    WHERE {% condition sessions.session_date %} created_date {% endcondition %}
    GROUP BY 1;;
  }

  # dimension: pk {
  #   hidden: yes
  #   primary_key: yes
  #   type: string
  #   #sql: ${created_date} || ${leader_name} ;;
  #   sql: ${leader_name} ;;
  # }

  # dimension: created_date {
  #   hidden: yes
  #   type: date
  #   datatype: date
  #   sql: ${TABLE}.created_date ;;
  # }

  dimension: leader_name {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${TABLE}.leader_name ;;
  }

  dimension: count_of_orders {
    hidden: yes
    type: number
    sql: ${TABLE}.count_of_orders ;;
  }

  measure: total_orders {
    type: sum
    sql: ${count_of_orders} ;;
  }

  measure: conversion_rate {
    type: number
    sql: ${total_orders} / nullif(${sessions.count},0) ;;
    value_format_name: percent_1
  }

}
