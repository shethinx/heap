view: sendgrid_events {
  sql_table_name: thinx_sendgrid_webhook.events ;;

  dimension: sg_event_id {
    group_label: "Sendgrid Event Information"
    primary_key: yes
    type: string
    sql: ${TABLE}.sg_event_id ;;
  }

# Different Dates in Sendgrid Information {

  dimension_group: _sdc_received {
    label: "Stitch Received"
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

  dimension: date {
    group_label: "Sendgrid Event Information"
    description: "String version of date, but doesn't contain time or timezone"
    type: date
    #stored as a date, I think it's stored in NYC time
    convert_tz: no
    sql: DATE(${TABLE}.date) ;;
  }

  dimension_group: timestamp {
    type: time
    description: "Epoch timeframe, appears in sync with the Stitch Received Date"
    datatype: epoch
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    #stored as epoch
    sql: ${TABLE}.timestamp ;;
  }

  dimension_group: sendgrid_send {
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
    #stored as a string
    sql: CAST(to_timestamp(nullif(${TABLE}.sendgrid_send_time,'None'),'YYYY-MM-DD HH24:MI:SS+00:00') as timestamp)  ;;
  }

#}

  dimension: asm_group_id {
    group_label: "Sendgrid Other Information"
    type: number
    sql: ${TABLE}.asm_group_id ;;
  }

  dimension: attempt {
    group_label: "Sendgrid Other Information"
    type: string
    sql: ${TABLE}.attempt ;;
  }

  dimension: cert_err {
    group_label: "Sendgrid Other Information"
    type: string
    sql: ${TABLE}.cert_err ;;
  }

  dimension: email {
    group_label: "Sendgrid Person Information"
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: event {
    group_label: "Sendgrid Event Information"
    type: string
    sql: ${TABLE}.event ;;
  }

  dimension: ip {
    group_label: "Sendgrid Person Information"
    type: string
    sql: ${TABLE}.ip ;;
  }

  dimension: journey_id {
    group_label: "Sendgrid Marketing Information"
    type: string
    sql: ${TABLE}.journey_id ;;
  }

  dimension: journey_name {
    group_label: "Sendgrid Marketing Information"
    type: string
    sql: ${TABLE}.journey_name ;;
  }

  dimension: marketing_campaign_id {
    group_label: "Sendgrid Marketing Information"
    type: number
    sql: ${TABLE}.marketing_campaign_id ;;
  }

  dimension: marketing_campaign_name {
    group_label: "Sendgrid Marketing Information"
    type: string
    sql: ${TABLE}.marketing_campaign_name ;;
  }

  dimension: marketing_campaign_split_id {
    group_label: "Sendgrid Marketing Information"
    type: number
    sql: ${TABLE}.marketing_campaign_split_id ;;
  }

  dimension: marketing_campaign_version {
    group_label: "Sendgrid Marketing Information"
    type: string
    sql: ${TABLE}.marketing_campaign_version ;;
  }

  dimension: reason {
    group_label: "Sendgrid Other Information"
    type: string
    sql: ${TABLE}.reason ;;
  }

  dimension: reseller_id {
    group_label: "Sendgrid Other Information"
    type: number
    sql: ${TABLE}.reseller_id ;;
  }

  dimension: response {
    group_label: "Sendgrid Event Information"
    type: string
    sql: ${TABLE}.response ;;
  }

  dimension: sendgrid_template_id {
    group_label: "Sendgrid Marketing Information"
    type: string
    sql: ${TABLE}.sendgrid_template_id ;;
  }

  dimension: sg_content_type {
    group_label: "Sendgrid Event Information"
    type: string
    sql: ${TABLE}.sg_content_type ;;
  }

  dimension: sg_message_id {
    group_label: "Sendgrid Marketing Information"
    type: string
    sql: ${TABLE}.sg_message_id ;;
  }

  dimension: sg_template_id {
    group_label: "Sendgrid Marketing Information"
    type: string
    sql: ${TABLE}.sg_template_id ;;
  }

  dimension: sg_template_name {
    group_label: "Sendgrid Marketing Information"
    type: string
    sql: ${TABLE}.sg_template_name ;;
  }

  dimension: sg_user_id {
    group_label: "Sendgrid Person Information"
    type: number
    sql: ${TABLE}.sg_user_id ;;
  }

  dimension: simon_batch_id {
    group_label: "Sendgrid Simon Information"
    type: string
    sql: ${TABLE}.simon_batch_id ;;
  }

  dimension: simon_flow_category {
    group_label: "Sendgrid Simon Information"
    type: string
    sql: ${TABLE}.simon_flow_category ;;
  }

  dimension: simon_flow_id {
    group_label: "Sendgrid Simon Information"
    type: string
    sql: ${TABLE}.simon_flow_id ;;
  }

  dimension: simon_flow_name {
    group_label: "Sendgrid Simon Information"
    type: string
    sql: ${TABLE}.simon_flow_name ;;
  }

  dimension: simon_flow_variant_id {
    group_label: "Sendgrid Simon Information"
    type: string
    sql: ${TABLE}.simon_flow_variant_id ;;
  }

  dimension: simon_flow_variant_name {
    group_label: "Sendgrid Simon Information"
    type: string
    sql: ${TABLE}.simon_flow_variant_name ;;
  }

  dimension: simon_segment_id {
    group_label: "Sendgrid Simon Information"
    type: string
    sql: ${TABLE}.simon_segment_id ;;
  }

  dimension: simon_segment_name {
    group_label: "Sendgrid Simon Information"
    type: string
    sql: ${TABLE}.simon_segment_name ;;
  }

  dimension: simon_tags {
    group_label: "Sendgrid Simon Information"
    type: string
    sql: ${TABLE}.simon_tags ;;
  }

  dimension: simon_template_id {
    group_label: "Sendgrid Simon Information"
    type: string
    sql: ${TABLE}.simon_template_id ;;
  }

  dimension: simon_template_name {
    group_label: "Sendgrid Simon Information"
    type: string
    sql: ${TABLE}.simon_template_name ;;
  }

  dimension: smtpid {
    group_label: "Sendgrid Other Information"
    type: string
    sql: ${TABLE}."smtp-id" ;;
  }

  dimension: status {
    group_label: "Sendgrid Event Information"
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: tls {
    group_label: "Sendgrid Other Information"
    type: number
    sql: ${TABLE}.tls ;;
  }

  dimension: type {
    group_label: "Sendgrid Event Information"
    type: string
    sql: ${TABLE}.type ;;
  }

  dimension: url {
    group_label: "Sendgrid Other Information"
    type: string
    sql: ${TABLE}.url ;;
  }

  dimension: url_offset__index {
    group_label: "Sendgrid Other Information"
    type: number
    sql: ${TABLE}.url_offset__index ;;
  }

  dimension: url_offset__type {
    group_label: "Sendgrid Other Information"
    type: string
    sql: ${TABLE}.url_offset__type ;;
  }

  dimension: useragent {
    group_label: "Sendgrid Other Information"
    type: string
    sql: ${TABLE}.useragent ;;
  }

  dimension_group: _sdc_batched {
    group_label: "Stitch Information"
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

  dimension: _sdc_sequence {
    group_label: "Stitch Information"
    hidden: yes
    type: number
    sql: ${TABLE}._sdc_sequence ;;
  }

  dimension: _sdc_table_version {
    group_label: "Stitch Information"
    hidden: yes
    type: number
    sql: ${TABLE}._sdc_table_version ;;
  }

  measure: count_of_all_events {
    group_label: "All Event Count"
    type: count
    drill_fields: [detail*]
  }

  measure: count_of_all_delivered {
    group_label: "All Event Count"
    type: count
    filters: [event: "delivered"]
    drill_fields: [detail*]
  }

  measure: count_of_all_open {
    group_label: "All Event Count"
    type: count
    filters: [event: "open"]
    drill_fields: [detail*]
  }

  measure: count_of_all_deferred {
    group_label: "All Event Count"
    type: count
    filters: [event: "deferred"]
    drill_fields: [detail*]
  }

  measure: count_of_all_dropped {
    group_label: "All Event Count"
    type: count
    filters: [event: "dropped"]
    drill_fields: [detail*]
  }

  measure: count_of_all_bounce {
    group_label: "All Event Count"
    type: count
    filters: [event: "bounce"]
    drill_fields: [detail*]
  }

  measure: count_of_all_click {
    group_label: "All Event Count"
    type: count
    filters: [event: "click"]
    drill_fields: [detail*]
  }

  measure: count_of_all_group_unsubscribe {
    group_label: "All Event Count"
    type: count
    filters: [event: "group_unsubscribe"]
    drill_fields: [detail*]
  }

  measure: count_of_all_unsubscribe {
    group_label: "All Event Count"
    type: count
    filters: [event: "unsubscribe"]
    drill_fields: [detail*]
  }

  measure: count_of_all_spam {
    group_label: "All Event Count"
    type: count
    filters: [event: "spamreport"]
    drill_fields: [detail*]
  }

  measure: count_of_all_group_resubscribe {
    group_label: "All Event Count"
    type: count
    filters: [event: "group_resubscribe"]
    drill_fields: [detail*]
  }

  measure: count_of_email_events {
    group_label: "Email Count"
    type: count_distinct
    sql: ${email} ;;
    drill_fields: [detail*]
  }

  measure: count_of_email_delivered {
    group_label: "Email Count"
    type: count_distinct
    sql: ${email} ;;
    filters: [event: "delivered"]
    drill_fields: [detail*]
  }

  measure: count_of_email_open {
    group_label: "Email Count"
    type: count_distinct
    sql: ${email} ;;
    filters: [event: "open"]
    drill_fields: [detail*]
  }

  measure: count_of_email_deferred {
    group_label: "Email Count"
    type: count_distinct
    sql: ${email} ;;
    filters: [event: "deferred"]
    drill_fields: [detail*]
  }

  measure: count_of_email_dropped {
    group_label: "Email Count"
    type: count_distinct
    sql: ${email} ;;
    filters: [event: "dropped"]
    drill_fields: [detail*]
  }

  measure: count_of_email_bounce {
    group_label: "Email Count"
    type: count_distinct
    sql: ${email} ;;
    filters: [event: "bounce"]
    drill_fields: [detail*]
  }

  measure: count_of_email_click {
    group_label: "Email Count"
    type: count_distinct
    sql: ${email} ;;
    filters: [event: "click"]
    drill_fields: [detail*]
  }

  measure: count_of_email_group_unsubscribe {
    group_label: "Email Count"
    type: count_distinct
    sql: ${email} ;;
    filters: [event: "group_unsubscribe"]
    drill_fields: [detail*]
  }

  measure: count_of_email_unsubscribe {
    group_label: "Email Count"
    type: count_distinct
    sql: ${email} ;;
    filters: [event: "unsubscribe"]
    drill_fields: [detail*]
  }

  measure: count_of_email_spam {
    group_label: "Email Count"
    type: count_distinct
    sql: ${email} ;;
    filters: [event: "spamreport"]
    drill_fields: [detail*]
  }

  measure: count_of_email_group_resubscribe {
    group_label: "Email Count"
    type: count_distinct
    sql: ${email} ;;
    filters: [event: "group_resubscribe"]
    drill_fields: [detail*]
  }

  measure: count_of_email_campaign_events {
    group_label: "Email Campaign Count"
    type: count_distinct
    sql: ${email} || ${marketing_campaign_id} ;;
    drill_fields: [detail*]
  }

  measure: count_of_email_campaign_delivered {
    group_label: "Email Campaign Count"
    type: count_distinct
    sql: ${email} || ${marketing_campaign_id} ;;
    filters: [event: "delivered"]
    drill_fields: [detail*]
  }

  measure: count_of_email_campaign_open {
    group_label: "Email Campaign Count"
    type: count_distinct
    sql: ${email} || ${marketing_campaign_id} ;;
    filters: [event: "open"]
    drill_fields: [detail*]
  }

  measure: count_of_email_campaign_deferred {
    group_label: "Email Campaign Count"
    type: count_distinct
    sql: ${email} || ${marketing_campaign_id} ;;
    filters: [event: "deferred"]
    drill_fields: [detail*]
  }

  measure: count_of_email_campaign_dropped {
    group_label: "Email Campaign Count"
    type: count_distinct
    sql: ${email} || ${marketing_campaign_id} ;;
    filters: [event: "dropped"]
    drill_fields: [detail*]
  }

  measure: count_of_email_campaign_bounce {
    group_label: "Email Campaign Count"
    type: count_distinct
    sql: ${email} || ${marketing_campaign_id} ;;
    filters: [event: "bounce"]
    drill_fields: [detail*]
  }

  measure: count_of_email_campaign_click {
    group_label: "Email Campaign Count"
    type: count_distinct
    sql: ${email} || ${marketing_campaign_id} ;;
    filters: [event: "click"]
    drill_fields: [detail*]
  }

  measure: count_of_email_campaign_group_unsubscribe {
    group_label: "Email Campaign Count"
    type: count_distinct
    sql: ${email} || ${marketing_campaign_id} ;;
    filters: [event: "group_unsubscribe"]
    drill_fields: [detail*]
  }

  measure: count_of_email_campaign_unsubscribe {
    group_label: "Email Campaign Count"
    type: count_distinct
    sql: ${email} || ${marketing_campaign_id} ;;
    filters: [event: "unsubscribe"]
    drill_fields: [detail*]
  }

  measure: count_of_email_campaign_spam {
    group_label: "Email Campaign Count"
    type: count_distinct
    sql: ${email} || ${marketing_campaign_id} ;;
    filters: [event: "spamreport"]
    drill_fields: [detail*]
  }

  measure: count_of_email_campaign_group_resubscribe {
    group_label: "Email Campaign Count"
    type: count_distinct
    sql: ${email} || ${marketing_campaign_id} ;;
    filters: [event: "group_resubscribe"]
    drill_fields: [detail*]
  }


  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      sg_event_id,
      date,
      event,
      email,
      marketing_campaign_id,
      marketing_campaign_name
    ]
  }
}
