view: sendgrid_events__category {
  sql_table_name: thinx_sendgrid_webhook.events__category ;;

  dimension_group: _sdc_batched {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}._sdc_batched_at ;;
  }

  dimension: _sdc_level_0_id {
    type: number
    sql: ${TABLE}._sdc_level_0_id ;;
  }

  dimension_group: _sdc_received {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}._sdc_received_at ;;
  }

  dimension: _sdc_sequence {
    type: number
    sql: ${TABLE}._sdc_sequence ;;
  }

  dimension: _sdc_source_key_email {
    type: string
    sql: ${TABLE}._sdc_source_key_email ;;
  }

  dimension: _sdc_source_key_event {
    type: string
    sql: ${TABLE}._sdc_source_key_event ;;
  }

  dimension: _sdc_source_key_timestamp {
    type: number
    sql: ${TABLE}._sdc_source_key_timestamp ;;
  }

  dimension: _sdc_table_version {
    type: number
    sql: ${TABLE}._sdc_table_version ;;
  }

  dimension: value {
    type: string
    sql: ${TABLE}.value ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
