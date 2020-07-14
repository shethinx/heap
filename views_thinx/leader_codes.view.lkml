view: leader_codes {
  sql_table_name: leaders_discount_codes.leader_codes ;;

  dimension: discount_code {
    primary_key: yes
    type: string
    sql: ${TABLE}.discountcode ;;
  }

  dimension: leader_email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: leader_name {
    type: string
    sql: ${TABLE}.leadername ;;
  }

  dimension: page_view_criteria {
    hidden: yes
    type: string
    sql: ${TABLE}.pageviewcriteria ;;
  }

  dimension_group: _sdc_batched {
    hidden: yes
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

  dimension_group: _sdc_received {
    hidden: yes
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
    hidden: yes
    type: number
    sql: ${TABLE}._sdc_sequence ;;
  }

  dimension: _sdc_table_version {
    hidden: yes
    type: number
    sql: ${TABLE}._sdc_table_version ;;
  }

}
