view: sendgrid_summary {
#   derived_table: {
#     datagroup_trigger: heap_refresh
#     distribution: "marketing_campaign_id"
#     sortkeys: ["timestamp_date"]
#     explore_source: sendgrid_events {
#       column: timestamp_date {}
#       column: marketing_campaign_id {}
#       column: marketing_campaign_name {}
#       column: event {}
#       column: count_of_all_events {}
#       column: count_of_email_campaign_events {}
#       column: count_of_email_events {}
#       filters: {
#         field: sendgrid_events.marketing_campaign_id
#         value: "NOT NULL"
#       }
#       timezone: America/New_York
#     }

  derived_table: {
    sql:
      SELECT
        DATE(CONVERT_TIMEZONE('UTC', 'America/New_York', (timestamp 'epoch' + sendgrid_events.timestamp  * interval '1 second'))) AS timestamp_date,
        sendgrid_events.marketing_campaign_id  AS marketing_campaign_id,
        sendgrid_events.marketing_campaign_name as marketing_campaign_name,
        {% if sendgrid_summary.event._in_query %} sendgrid_events.event as event, {% endif %}
        COUNT(*) AS count_of_all_events,
        COUNT(DISTINCT sendgrid_events.email || sendgrid_events.marketing_campaign_id ) AS count_of_email_campaign_events,
        COUNT(DISTINCT sendgrid_events.email ) AS count_of_email_events
      FROM thinx_sendgrid_webhook.events  AS sendgrid_events
      WHERE 1=1
        and {% condition marketing_campaign_id %} marketing_campaign_id {% endcondition %}
        and {% condition marketing_campaign_name %} marketing_campaign_name {% endcondition %}
        and {% condition event_date %} timestamp_date {% endcondition %}
        and {% condition sessions.session_date %} timestamp_date {% endcondition %}
      GROUP BY 1,2,3 {% if sendgrid_summary.event._in_query %} ,4 {% endif %}
        ;;
  }

  dimension: primary_key {
    hidden: yes
    primary_key: yes
    type: number
    sql: TO_CHAR(${event_raw},'YYYYMMDD') || '|' || ${marketing_campaign_id}|| '|' {% if sendgrid_summary.event._in_query %} || sendgrid_summary.event {% endif %} ;;
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
    suggest_explore: sendgrid_campaigns
    suggest_dimension: marketing_campaign_id
  }
  dimension: marketing_campaign_name {
    type: string
    sql: ${TABLE}.marketing_campaign_name ;;
    suggest_explore: sendgrid_campaigns
    suggest_dimension: marketing_campaign_name
  }
  dimension: event {
    type: string
    sql: ${TABLE}.event ;;
    suggest_explore: sendgrid_campaigns
    suggest_dimension: event
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
