view: sendgrid_summary {

  derived_table: {
    explore_source: sendgrid_events {
      column: timestamp_date {}
      column: marketing_campaign_id {}
      column: marketing_campaign_name {}
      column: count_of_all_events {}
      column: count_of_all_bounce {}
      column: count_of_all_click {}
      column: count_of_all_deferred {}
      column: count_of_all_delivered {}
      column: count_of_all_dropped {}
      column: count_of_all_group_resubscribe {}
      column: count_of_all_group_unsubscribe {}
      column: count_of_all_open {}
      column: count_of_all_spam {}
      column: count_of_all_unsubscribe {}
      column: count_of_email_campaign_events {}
      column: count_of_email_campaign_bounce {}
      column: count_of_email_campaign_click {}
      column: count_of_email_campaign_deferred {}
      column: count_of_email_campaign_delivered {}
      column: count_of_email_campaign_dropped {}
      column: count_of_email_campaign_group_resubscribe {}
      column: count_of_email_campaign_group_unsubscribe {}
      column: count_of_email_campaign_open {}
      column: count_of_email_campaign_spam {}
      column: count_of_email_campaign_unsubscribe {}
      column: count_of_email_events {}
      column: count_of_email_bounce {}
      column: count_of_email_click {}
      column: count_of_email_deferred {}
      column: count_of_email_delivered {}
      column: count_of_email_dropped {}
      column: count_of_email_group_resubscribe {}
      column: count_of_email_group_unsubscribe {}
      column: count_of_email_open {}
      column: count_of_email_spam {}
      column: count_of_email_unsubscribe {}
      timezone: America/New_York
      bind_filters: {
        from_field: sessions.session_date
        to_field: sendgrid_events.timestamp_date
      }
      bind_filters: {
        #disabled the ability to filter on event date from the front end UI, but put in just in case
        from_field: sendgrid_summary.event_date
        to_field: sendgrid_events.timestamp_date
      }
      bind_filters: {
        from_field: sendgrid_summary.marketing_campaign_name
        to_field: sendgrid_events.marketing_campaign_name
      }
    }
  }

  dimension: primary_key {
    hidden: yes
    primary_key: yes
    type: number
    sql: TO_CHAR(${event_raw},'YYYYMMDD') || '|' || ${marketing_campaign_id} ;;
  }

  dimension_group: event {
    description: "Filter on session date"
    type: time
    datatype: date
    timeframes: [raw,date,week,month,quarter,year]
    can_filter: no
    sql: ${TABLE}.timestamp_date ;;
  }
  dimension: marketing_campaign_id {
    type: number
    sql: ${TABLE}.marketing_campaign_id ;;
    suggest_explore: sendgrid_events
    suggest_dimension: sendgrid_events.marketing_campaign_id
  }
  dimension: marketing_campaign_name {
    type: string
    sql: ${TABLE}.marketing_campaign_name ;;
    suggest_explore: sendgrid_events
    suggest_dimension: sendgrid_events.marketing_campaign_name
  }
  dimension: count_of_all_events {
    hidden: yes
    type: number
    sql: ${TABLE}.count_of_all_events ;;
  }
  dimension: count_of_all_bounce {
    hidden: yes
    type: number
    sql: ${TABLE}.count_of_all_bounce ;;
  }
  dimension: count_of_all_click {
    hidden: yes
    type: number
    sql: ${TABLE}.count_of_all_click ;;
  }
  dimension: count_of_all_deferred {
    hidden: yes
    type: number
    sql: ${TABLE}.count_of_all_deferred ;;
  }
  dimension: count_of_all_delivered {
    hidden: yes
    type: number
    sql: ${TABLE}.count_of_all_delivered ;;
  }
  dimension: count_of_all_dropped {
    hidden: yes
    type: number
    sql: ${TABLE}.count_of_all_dropped ;;
  }
  dimension: count_of_all_group_resubscribe {
    hidden: yes
    type: number
    sql: ${TABLE}.count_of_all_group_resubscribe ;;
  }
  dimension: count_of_all_group_unsubscribe {
    hidden: yes
    type: number
    sql: ${TABLE}.count_of_all_group_unsubscribe ;;
  }
  dimension: count_of_all_open {
    hidden: yes
    type: number
    sql: ${TABLE}.count_of_all_open ;;
  }
  dimension: count_of_all_spam {
    hidden: yes
    type: number
    sql: ${TABLE}.count_of_all_spam ;;
  }
  dimension: count_of_all_unsubscribe {
    hidden: yes
    type: number
    sql: ${TABLE}.count_of_all_unsubscribe ;;
  }
  dimension: count_of_email_campaign_events {
    hidden: yes
    type: number
    sql: ${TABLE}.count_of_email_campaign_events ;;
  }
  dimension: count_of_email_campaign_bounce {
    hidden: yes
    type: number
    sql: ${TABLE}.count_of_email_campaign_bounce ;;
  }
  dimension: count_of_email_campaign_click {
    hidden: yes
    type: number
    sql: ${TABLE}.count_of_email_campaign_click ;;
  }
  dimension: count_of_email_campaign_deferred {
    hidden: yes
    type: number
    sql: ${TABLE}.count_of_email_campaign_deferred ;;
  }
  dimension: count_of_email_campaign_delivered {
    hidden: yes
    type: number
    sql: ${TABLE}.count_of_email_campaign_delivered ;;
  }
  dimension: count_of_email_campaign_dropped {
    hidden: yes
    type: number
    sql: ${TABLE}.count_of_email_campaign_dropped ;;
  }
  dimension: count_of_email_campaign_group_resubscribe {
    hidden: yes
    type: number
    sql: ${TABLE}.count_of_email_campaign_group_resubscribe ;;
  }
  dimension: count_of_email_campaign_group_unsubscribe {
    hidden: yes
    type: number
    sql: ${TABLE}.count_of_email_campaign_group_unsubscribe ;;
  }
  dimension: count_of_email_campaign_open {
    hidden: yes
    type: number
    sql: ${TABLE}.count_of_email_campaign_open ;;
  }
  dimension: count_of_email_campaign_spam {
    hidden: yes
    type: number
    sql: ${TABLE}.count_of_email_campaign_spam ;;
  }
  dimension: count_of_email_campaign_unsubscribe {
    hidden: yes
    type: number
    sql: ${TABLE}.count_of_email_campaign_unsubscribe ;;
  }
  dimension: count_of_email_events {
    hidden: yes
    type: number
    sql: ${TABLE}.count_of_email_events ;;
  }
  dimension: count_of_email_bounce {
    hidden: yes
    type: number
    sql: ${TABLE}.count_of_email_bounce ;;
  }
  dimension: count_of_email_click {
    hidden: yes
    type: number
    sql: ${TABLE}.count_of_email_click ;;
  }
  dimension: count_of_email_deferred {
    hidden: yes
    type: number
    sql: ${TABLE}.count_of_email_deferred ;;
  }
  dimension: count_of_email_delivered {
    hidden: yes
    type: number
    sql: ${TABLE}.count_of_email_delivered ;;
  }
  dimension: count_of_email_dropped {
    hidden: yes
    type: number
    sql: ${TABLE}.count_of_email_dropped ;;
  }
  dimension: count_of_email_group_resubscribe {
    hidden: yes
    type: number
    sql: ${TABLE}.count_of_email_group_resubscribe ;;
  }
  dimension: count_of_email_group_unsubscribe {
    hidden: yes
    type: number
    sql: ${TABLE}.count_of_email_group_unsubscribe ;;
  }
  dimension: count_of_email_open {
    hidden: yes
    type: number
    sql: ${TABLE}.count_of_email_open ;;
  }
  dimension: count_of_email_spam {
    hidden: yes
    type: number
    sql: ${TABLE}.count_of_email_spam ;;
  }
  dimension: count_of_email_unsubscribe {
    hidden: yes
    type: number
    sql: ${TABLE}.count_of_email_unsubscribe ;;
  }


  measure: total_count_of_all_events {
    group_label: "All Event Count"
    type: sum
    sql: ${count_of_all_events} ;;
  }

  measure: total_count_of_all_bounce_events {
    group_label: "All Event Count"
    type: sum
    sql: ${count_of_all_bounce} ;;
  }

  measure: total_count_of_all_click  {
    group_label: "All Event Count"
    type: sum
    sql: ${count_of_all_click} ;;
  }

  measure: total_count_of_all_deferred  {
    group_label: "All Event Count"
    type: sum
    sql: ${count_of_all_deferred} ;;
  }

  measure: total_count_of_all_delivered {
    group_label: "All Event Count"
    type: sum
    sql: ${count_of_all_delivered} ;;
  }

  measure: total_count_of_all_dropped {
    group_label: "All Event Count"
    type: sum
    sql: ${count_of_all_dropped} ;;
  }

  measure: total_count_of_all_group_resubscribe {
    group_label: "All Event Count"
    type: sum
    sql: ${count_of_all_group_resubscribe} ;;
  }

  measure: total_count_of_all_group_unsubscribe {
    group_label: "All Event Count"
    type: sum
    sql: ${count_of_all_group_unsubscribe} ;;
  }

  measure: total_count_of_all_open {
    group_label: "All Event Count"
    type: sum
    sql: ${count_of_all_open} ;;
  }

  measure: total_count_of_all_spam {
    group_label: "All Event Count"
    type: sum
    sql: ${count_of_all_spam} ;;
  }

  measure: total_count_of_all_unsubscribe {
    group_label: "All Event Count"
    type: sum
    sql: ${count_of_all_unsubscribe} ;;
  }

  measure: total_count_of_email_campaign_events {
    group_label: "Email Campaign Count"
    type: sum
    sql: ${count_of_email_campaign_events} ;;
  }

  measure: total_count_of_email_campaign_bounce {
    group_label: "Email Campaign Count"
    type: sum
    sql: ${count_of_email_campaign_bounce} ;;
  }

  measure: total_count_of_email_campaign_click {
    group_label: "Email Campaign Count"
    type: sum
    sql: ${count_of_email_campaign_click} ;;
  }

  measure: total_count_of_email_campaign_deferred {
    group_label: "Email Campaign Count"
    type: sum
    sql: ${count_of_email_campaign_deferred} ;;
  }

  measure: total_count_of_email_campaign_delivered {
    group_label: "Email Campaign Count"
    type: sum
    sql: ${count_of_email_campaign_delivered} ;;
  }

  measure: total_count_of_email_campaign_dropped {
    group_label: "Email Campaign Count"
    type: sum
    sql: ${count_of_email_campaign_dropped} ;;
  }

  measure: total_count_of_email_campaign_group_resubscribe {
    group_label: "Email Campaign Count"
    type: sum
    sql: ${count_of_email_campaign_group_resubscribe} ;;
  }

  measure: total_count_of_email_campaign_group_unsubscribe {
    group_label: "Email Campaign Count"
    type: sum
    sql: ${count_of_email_campaign_group_unsubscribe} ;;
  }

  measure: total_count_of_email_campaign_open {
    group_label: "Email Campaign Count"
    type: sum
    sql: ${count_of_email_campaign_open} ;;
  }

  measure: total_count_of_email_campaign_spam {
    group_label: "Email Campaign Count"
    type: sum
    sql: ${count_of_email_campaign_spam} ;;
  }

  measure: total_count_of_email_campaign_unsubscribe {
    group_label: "Email Campaign Count"
    type: sum
    sql: ${count_of_email_campaign_unsubscribe} ;;
  }

  measure: total_count_of_email_events {
    group_label: "Email Count"
    type: sum
    sql: ${count_of_email_events} ;;
  }

  measure: total_count_of_email_bounce {
    group_label: "Email Count"
    type: sum
    sql: ${count_of_email_bounce} ;;
  }

  measure: total_count_of_email_click {
    group_label: "Email Count"
    type: sum
    sql: ${count_of_email_click} ;;
  }

  measure: total_count_of_email_deferred {
    group_label: "Email Count"
    type: sum
    sql: ${count_of_email_deferred} ;;
  }

  measure: total_count_of_email_delivered {
    group_label: "Email Count"
    type: sum
    sql: ${count_of_email_delivered} ;;
  }

  measure: total_count_of_email_dropped {
    group_label: "Email Count"
    type: sum
    sql: ${count_of_email_dropped} ;;
  }

  measure: total_count_of_email_group_resubscribe {
    group_label: "Email Count"
    type: sum
    sql: ${count_of_email_group_resubscribe} ;;
  }

  measure: total_count_of_email_group_unsubscribe {
    group_label: "Email Count"
    type: sum
    sql: ${count_of_email_group_unsubscribe} ;;
  }

  measure: total_count_of_email_open {
    group_label: "Email Count"
    type: sum
    sql: ${count_of_email_open} ;;
  }

  measure: total_count_of_email_spam {
    group_label: "Email Count"
    type: sum
    sql: ${count_of_email_spam} ;;
  }

  measure: total_count_of_email_unsubscribe {
    group_label: "Email Count"
    type: sum
    sql: ${count_of_email_unsubscribe} ;;
  }

  measure: open_rate {
    group_label: "Marketing Metrics"
    description: "Count of All Open / Count of All Delivered"
    type: number
    sql: 1.0 * ${total_count_of_all_open} / nullif(${total_count_of_all_delivered},0) ;;
    value_format_name: percent_1
  }

  measure: ctr {
    group_label: "Marketing Metrics"
    label: "CTR"
    description: "Count of All Click / Count of All Delivered"
    type: number
    sql: 1.0 * ${total_count_of_all_click} / nullif(${total_count_of_all_delivered},0) ;;
    value_format_name: percent_1
  }

  measure: spam_rate {
    group_label: "Marketing Metrics"
    description: "Count of All Spam / Count of All Delivered"
    type: number
    sql: 1.0 * ${total_count_of_all_spam} / nullif(${total_count_of_all_delivered},0) ;;
    value_format_name: percent_1
  }

  measure: unsub_rate {
    group_label: "Marketing Metrics"
    description: "Count of All Unsubscribe / Count of All Delivered"
    type: number
    sql: 1.0 * ${total_count_of_all_unsubscribe} / nullif(${total_count_of_all_delivered},0) ;;
    value_format_name: percent_1
  }

  measure: cvr {
    group_label: "Marketing Metrics"
    label: "CVR"
    description: "Total Count of Orders / Count of All Delivered"
    type: number
    sql: 1.0 * ${heap_orders_sales_summary_ndt.total_count_of_orders} / nullif(${total_count_of_all_delivered},0) ;;
    value_format_name: percent_1
  }

  measure: revenue_per_delivered {
    group_label: "Marketing Metrics"
    description: "Total Gross Sales / Count of All Delivered"
    type: number
    sql: 1.0 * ${heap_orders_sales_summary_ndt.total_gross_sales} / nullif(${total_count_of_all_delivered},0) ;;
    value_format_name: percent_1
  }

#CVR (heap.shopify orders/delivered)
#Revenue per Delivered (heap.shopify gross / delivered)



#   went with a dynamic sql derived table for accurate reporting on distinct counts
#   derived_table: {
#     sql:
#       SELECT
#         DATE(CONVERT_TIMEZONE('UTC', 'America/New_York', (timestamp 'epoch' + sendgrid_events.timestamp  * interval '1 second'))) AS timestamp_date,
#         sendgrid_events.marketing_campaign_id  AS marketing_campaign_id,
#         sendgrid_events.marketing_campaign_name as marketing_campaign_name,
#         {% if sendgrid_summary.event._in_query %} sendgrid_events.event as event, {% endif %}
#         COUNT(*) AS count_of_all_events,
#         COUNT(DISTINCT sendgrid_events.email || sendgrid_events.marketing_campaign_id ) AS count_of_email_campaign_events,
#         COUNT(DISTINCT sendgrid_events.email ) AS count_of_email_events
#       FROM thinx_sendgrid_webhook.events  AS sendgrid_events
#       WHERE 1=1
#         and {% condition marketing_campaign_id %} marketing_campaign_id {% endcondition %}
#         and {% condition marketing_campaign_name %} marketing_campaign_name {% endcondition %}
#         and {% condition event_date %} timestamp_date {% endcondition %}
#         and {% condition sessions.session_date %} timestamp_date {% endcondition %}
#         and {% condition sendgrid_summary.event %} event {% endcondition %}
#       GROUP BY 1,2,3 {% if sendgrid_summary.event._in_query %} ,4 {% endif %}
#         ;;
#   }

}
