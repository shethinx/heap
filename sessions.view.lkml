view: sessions {
  sql_table_name: heap_thinx.sessions ;;

  dimension: session_id {
    type: number
    sql: ${TABLE}.session_id ;;
  }

  dimension: session_unique_id {
    hidden: yes
    type: string
    primary_key: yes
    sql: ${session_id} || '-' || ${user_id} ;;
  }

  dimension: app_name {
    sql: ${TABLE}.app_name ;;
  }

  dimension: app_version {
    sql: ${TABLE}.app_version ;;
  }

  dimension: browser {
    sql: ${TABLE}.browser ;;
  }

  dimension: carrier {
    sql: ${TABLE}.carrier ;;
  }

  dimension: city {
    sql: ${TABLE}.city ;;
  }

  dimension: country {
    sql: CASE WHEN ${TABLE}.country = 'United States' THEN 'United States of America' ELSE ${TABLE}.country END ;;
  }

  dimension: device_type {
    sql: ${TABLE}.device_type ;;
  }

  dimension: event_id {
    type: number
    sql: ${TABLE}.event_id ;;
  }

  dimension: ip {
    type: string
    sql: ${TABLE}.ip ;;
  }

  dimension: landing_page {
    sql: ${TABLE}.landing_page ;;
  }

  dimension: library {
    sql: ${TABLE}.library ;;
  }

  dimension: phone_model {
    sql: ${TABLE}.phone_model ;;
  }

  dimension: platform {
    sql: ${TABLE}.platform ;;
  }

  dimension: referrer {
    sql: ${TABLE}.referrer ;;
  }

  dimension: referrer_abbreviated {
    type: string
    sql: regexp_replace(${TABLE}.referrer, '(http://)|(https://)|(www.)|/$', '');;
  }

  dimension: referrer_domain {
    sql: split_part(${referrer},'/',3) ;;
  }

  dimension: referrer_domain_mapped {
    sql: CASE WHEN ${referrer_domain} like '%facebook%' THEN 'facebook' WHEN ${referrer_domain} like '%google%' THEN 'google' ELSE ${referrer_domain} END ;;
    html: {{ linked_value }}
      <a href="/dashboards/heap_block::referrer_dashboard?referrer_domain={{ value | encode_uri }}" target="_new">
      <img src="/images/qr-graph-line@2x.png" height=20 width=20></a>
      ;;
  }

  dimension: region {
    sql: ${TABLE}.region ;;
  }

  dimension: search_keyword {
    sql: ${TABLE}.search_keyword ;;
  }

  dimension_group: session {
    type: time
    timeframes: [time, date, week, month, hour_of_day, day_of_week_index]
    sql: ${TABLE}.time ;;
  }

  dimension: user_id {
    type: number
    # hidden: true
    sql: ${TABLE}.user_id ;;
  }

  dimension: utm_campaign {
    sql: ${TABLE}.utm_campaign ;;
  }

  dimension: utm_content {
    sql: ${TABLE}.utm_content ;;
  }

  dimension: utm_medium {
    sql: ${TABLE}.utm_medium ;;
  }

  dimension: utm_source {
    sql: ${TABLE}.utm_source ;;
  }

  dimension: source_medium {
    type: string
    sql: ${utm_source} || '/' || ${utm_medium} ;;
  }

  dimension: utm_term {
    sql: ${TABLE}.utm_term ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: count_distinct_ip {
    type: count_distinct
    sql: ${TABLE}.ip ;;
  }

  measure: count_users {
    type: count_distinct
    sql: ${user_id} ;;
    drill_fields: [user_id]
  }

  measure: average_sessions_per_user {
    type: number
    sql: ${count}::float/nullif(${count_users},0) ;;
    value_format_name: decimal_1
  }

  dimension: referrer_bucket {
    type: string
    sql: CASE
      WHEN ${TABLE}.referrer ILIKE '%google%' THEN 'Google'
      WHEN ${TABLE}.referrer ILIKE '%instagram%' THEN 'Instagram'
      WHEN ${TABLE}.referrer ILIKE '%acebook%' THEN 'Facebook'
      WHEN ${TABLE}.referrer ILIKE '%bing%'  THEN 'Bing'
      WHEN ${TABLE}.referrer ILIKE '%pinterest%'  THEN 'Pinterest'
      WHEN ${TABLE}.referrer ILIKE '%yahoo%'  THEN 'Yahoo'
      WHEN ${TABLE}.referrer ILIKE '%youtube%' THEN 'YouTube'
      WHEN ${TABLE}.referrer IS NULL THEN 'Direct'
      WHEN ${TABLE}.referrer NOT ILIKE '%shethinx%' THEN 'Other'
      --ELSE 'Other' to leave out shethinx
      END ;;
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [session_id, app_name, user_id, utm_source, users.identity]
  }
}
