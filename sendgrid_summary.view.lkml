view: sendgrid_summary {
  derived_table: {
    datagroup_trigger: heap_refresh
    distribution: "marketing_campaign_id"
    sortkeys: ["timestamp_date"]
    explore_source: sendgrid_events {
      column: timestamp_date {}
      column: marketing_campaign_id {}
      column: marketing_campaign_name {}
      column: count_of_all_events {}
      column: count_of_email_campaign_events {}
      column: count_of_email_events {}
      column: event {}
      filters: {
        field: sendgrid_events.marketing_campaign_id
        value: "NOT NULL"
      }
      timezone: UTC
    }
  }

  dimension: primary_key {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${event_raw} || ${marketing_campaign_id} || ${event} ;;
  }
  dimension_group: event {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    sql: ${TABLE}.timestamp_date ;;
  }
  dimension: marketing_campaign_id {
    type: number
    sql: ${TABLE}.marketing_campaign_id ;;
  }
  dimension: marketing_campaign_name {
    type: string
    sql: ${TABLE}.marketing_campaign_name ;;
  }
  dimension: event {
    type: string
    sql: ${TABLE}.event ;;
  }
  dimension: count_of_all_events_dim {
    hidden: yes
    type: number
    sql: ${TABLE}.count_of_all_events ;;
  }
  dimension: count_of_email_campaign_events_dim {
    hidden: yes
    type: number
    sql: ${TABLE}.count_of_email_campaign_events ;;
  }
  dimension: count_of_email_events_dim {
    hidden: yes
    type: number
    sql: ${TABLE}.count_of_email_events ;;
  }
  measure: count_of_all_events {
    type: sum
    sql: ${count_of_all_events_dim} ;;
  }
  measure: count_of_email_campaign_events {
    type: sum
    sql: ${count_of_email_campaign_events_dim} ;;
  }
  measure: count_of_email_events {
    type: sum
    sql: ${count_of_email_events_dim} ;;
  }

}
