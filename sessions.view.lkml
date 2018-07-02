view: sessions {
  label: "Sessions Thinx"
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

  measure: total_sessions {
    type: count_distinct
    sql: ${session_id} ;;
  }

# Heap's referrer column includes the UTMs
# Heap doesn't enable us to differentiate btw organic search and paid search. For some reason Heap doesn't show the gclid, which is how I differentiate those two in Shopify data.
# Can see referrer column from Google includes either search? or url? for people typing the url into the chrome url/search bar.
  dimension: source_we_defined {
    type: string
    sql: CASE
      WHEN ${TABLE}.referrer ILIKE '%gilt%' then 'Gilt'
      WHEN ${TABLE}.referrer ILIKE '%friendbuy%'
        or ${TABLE}.referrer ILIKE '%friendbuy%'
        or ${TABLE}.landing_page ilike '%friendbuy%'
        or ${TABLE}.landing_page ilike '%fbuy%'
        or ${TABLE}.referrer ILIKE '%fbuy%'
        OR ${TABLE}.landing_page ILIKE '%affiliate%'
        THEN 'Friendbuy'
      WHEN ${TABLE}.landing_page ilike '%gclid%'
        or ${TABLE}.referrer ILIKE '%gclid%'
        or (${TABLE}.referrer ILIKE '%google%'
        and
        (
        ${TABLE}.referrer  ilike '%utm%'
        or ${TABLE}.referrer  ilike '%ad%'
        --or ${TABLE}.referrer  ilike '%search%'
        or ${TABLE}.referrer  ilike '%aclk%'
        or ${TABLE}.referrer  ilike '%googlesyndication%'
        or ${TABLE}.referrer  ilike '%doubleclick%'
        ))
        THEN 'Adwords'
      WHEN ${TABLE}.referrer ILIKE '%instagram%'
        OR ${TABLE}.referrer ILIKE '%facebook%'
        OR ${TABLE}.referrer ILIKE '%fbig%'
        or ${TABLE}.landing_page ilike '%fbig%'
        or ${TABLE}.landing_page ilike '%instagram%'
        THEN 'FBIG'
      WHEN  ${TABLE}.referrer ILIKE '%pinterest%'
        or ${TABLE}.landing_page ilike '%pinterest%'
        THEN 'Pinterest'
      WHEN ${TABLE}.referrer ILIKE '%youtube%'
        or ${TABLE}.landing_page ilike '%youtube%'
        THEN 'YouTube'
      WHEN ${TABLE}.referrer ILIKE '%yahoo%'
         or ${TABLE}.landing_page ilike '%yahoo%'
        THEN 'Yahoo'
      WHEN ${TABLE}.referrer ILIKE '%bing%'
        or ${TABLE}.landing_page ILIKE '%bing%'
        THEN 'Bing'
      WHEN ${TABLE}.landing_page not ILIKE '%checkout%'
        and (${TABLE}.referrer ILIKE '%mail%'
        or ${TABLE}.landing_page ILIKE '%mail%'
        or ${TABLE}.referrer ILIKE '%outlook%'
        or ${TABLE}.referrer ILIKE '%google.android.gm%')
        THEN 'Email'
      WHEN ${TABLE}.referrer ILIKE '%google%'
        --and len(${TABLE}.referrer) < 60
        THEN 'Google Organic'
      WHEN ${TABLE}.referrer ILIKE '%www.shethinx.com%'
        or ${TABLE}.referrer ILIKE '%www.hellothinx.com%'
        or ${TABLE}.referrer ILIKE '%www.iconundies.com%'
        then 'Direct'
      WHEN ${TABLE}.referrer is null
        and ${TABLE}.landing_page is null
        THEN 'Direct'
      ELSE 'Other'
      END ;;
  }

  dimension: marketing_channel{
    type: string
    sql: CASE
    when ${TABLE}.utm_medium ILIKE '%email%'
    or ${TABLE}.referrer ILIKE '%mail.google.com%'
    or ${TABLE}.referrer ILIKE '%outlook.live.com%'
    or ${TABLE}.referrer ILIKE '%mail.yahoo.com%'
      THEN 'Email'
    when ${TABLE}.utm_medium ILIKE '%affiliate%'
    or ${TABLE}.utm_source ILIKE '%pepperjam%'
      THEN 'Affiliate'
    when ${TABLE}.utm_medium ILIKE '%display%'
    or ${TABLE}.utm_source ILIKE '%gdn%'
    or ${TABLE}.referrer ILIKE '%criteo%'
    or ${TABLE}.referrer ILIKE '%googleads.g.doubleclick.net%'
    or ${TABLE}.referrer ILIKE '%tpc.googlesyndication.com%'
      THEN 'Display'
    when (${TABLE}.referrer ILIKE '%google%'
    or ${TABLE}.referrer ILIKE '%bing%'
    or ${TABLE}.referrer ILIKE '%yahoo%'
    or ${TABLE}.referrer ILIKE '%msn%'
    or ${TABLE}.referrer ILIKE '%ask%'
    or ${TABLE}.referrer ILIKE '%baidu%'
    or ${TABLE}.referrer ILIKE '%yandex%'
    or ${TABLE}.referrer ILIKE '%duckduckgo%'
    )
    and ${TABLE}.utm_medium IS NOT NULL
    or ${TABLE}.landing_page ILIKE '%gclid=%'
    or ${TABLE}.landing_page ILIKE '%msclkid=%'
      THEN 'Paid Search'
    when ${TABLE}.utm_source ILIKE '%FBIG%'
    or (${TABLE}.referrer ILIKE '%twitter.com%'
    or ${TABLE}.referrer ILIKE '%linkedin.com%'
    or ${TABLE}.referrer ILIKE '%lnkd.in%'
    or ${TABLE}.referrer ILIKE '%reddit.com%'
    or ${TABLE}.referrer ILIKE '%pinterest.com%'
    or ${TABLE}.referrer ILIKE '%snapchat.com%'
    or ${TABLE}.referrer ILIKE '%youtube.com%'
    ) and ${TABLE}.utm_medium IS NOT NULL
    or ${TABLE}.landing_page ILIKE '%fbaid=%'
    or ${TABLE}.landing_page ILIKE '%licid=%'
      THEN 'Paid Social'
    when ${TABLE}.referrer ILIKE '%google%'
    or ${TABLE}.referrer ILIKE '%bing%'
    or ${TABLE}.referrer ILIKE '%yahoo%'
    or ${TABLE}.referrer ILIKE '%msn%'
    or ${TABLE}.referrer ILIKE '%ask%'
    or ${TABLE}.referrer ILIKE '%baidu%'
    or ${TABLE}.referrer ILIKE '%yandex%'
    or ${TABLE}.referrer ILIKE '%duckduckgo%'
      THEN 'Organic Search'
    when ${TABLE}.referrer ILIKE '%twitter.com%'
    or ${TABLE}.referrer ILIKE '%linkedin.com%'
    or ${TABLE}.referrer ILIKE '%lnkd.in%'
    or ${TABLE}.referrer ILIKE '%reddit.com%'
    or ${TABLE}.referrer ILIKE '%pinterest.com%'
    or ${TABLE}.referrer ILIKE '%snapchat.com%'
    or ${TABLE}.referrer ILIKE '%youtube.com%'
      THEN 'Organic Social'
    when ${TABLE}.utm_source ILIKE '%email%'
      THEN 'Email'
    when ${TABLE}.utm_source ILIKE '%Friendbuy%'
      THEN 'Refer-A-Friend'
    when ${TABLE}.utm_medium IS NOT NULL
      THEN 'Other Channel'
    when ${TABLE}.referrer IS NULL
    or ${TABLE}.referrer ILIKE '%android-app%'
    or ${TABLE}.referrer ILIKE '%shethinx.com%'
      THEN 'Direct'
    when ${TABLE}.referrer IS NOT NULL
      THEN 'Other Referral'
    ELSE 'Other Referral'
    END;;
  }

  measure: organic_direct_sessions_count {
    type: count_distinct
    filters: {
      field:  marketing_channel
      value: "Organic Search, Organic Social, Direct"
    }
    filters: {
      field:  landing_page
      value: "-%utm%,-%UTM%,-%gclid%"
    }
    sql: ${TABLE}.ip  ;;
  }

  measure: direct_sessions_count {
    type: count_distinct
    filters: {
      field:  marketing_channel
      value: "Direct"
    }
    filters: {
      field:  landing_page
      value: "-%utm%,-%UTM%,-%gclid%"
    }
    sql: ${TABLE}.ip  ;;
  }


  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [session_id, app_name, user_id, utm_source, users.identity]
  }
}
