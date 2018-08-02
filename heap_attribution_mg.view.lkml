view: heap_attribution_mg {
  derived_table: {
    sql:
    with users as(
    select
    user_id,
    total_spent,
    orders_count
    from {{ _model._name }}.users
    where total_spent > 0
    ),

    all_sessions as(
    select
    sessions.user_id,
    sessions.session_id,
    sessions.time,
    sessions.referrer,
    sessions.landing_page,
    sessions.utm_source,
    sessions.utm_medium,
    row_number() over( partition by sessions.user_id order by min(sessions.time)) as session_sequence_number
    from users left join {{ _model._name }}.sessions as sessions on sessions.user_id = users.user_id
    group by 1,2,3,4,5,6,7),

    first_session as(
    select
    user_id,
    referrer,
    landing_page,
    utm_source,
    utm_medium,
    time
    from all_sessions where session_sequence_number = 1),
    order_completed as(
    select
    order_completed.user_id,
    order_completed.time as order_time,
    order_completed.session_id,
    order_completed.revenue,
    order_completed.referrer as last_touch_referrer,
    order_completed.landing_page as last_touch_landing_page,
    order_completed.utm_source as last_touch_utm_source,
    order_completed.utm_medium as last_touch_utm_medium,
    first_session.referrer as referrer,
    first_session.landing_page as landing_page,
    first_session.utm_source as utm_source,
    first_session.utm_medium as utm_medium,
    first_session.time as first_touch_time,
    datediff('day', first_touch_time, order_time) as time_between_first_and_last_touch,
    a.session_sequence_number
    from {{ _model._name }}.order_completed
    left join all_sessions as a on order_completed.session_id = a.session_id
    left join first_session on order_completed.user_id = first_session.user_id)


    select
    distinct
    *
    From users join order_completed using(user_id)
    ;;
  }

  measure: count {
    type: count
  }

  measure: average_touches_to_convert {
    type: average
    sql: ${TABLE}.session_sequence_number ;;
  }

  measure: average_time_to_convert {
    type: average
    sql: ${TABLE}.time_between_first_and_last_touch ;;
  }

  dimension_group: first_touch_time{
    type: time
    sql: ${TABLE}.first_touch_time ;;
  }

  dimension_group: order_time {
    type: time
    sql: ${TABLE}.order_time ;;
  }

  dimension: last_touch_marketing_channel {
    type: string
    sql: CASE
          when ${TABLE}.last_touch_utm_medium ILIKE '%email%'
          or ${TABLE}.last_touch_referrer ILIKE '%mail.google.com%'
          or ${TABLE}.last_touch_referrer ILIKE '%outlook.live.com%'
          or ${TABLE}.last_touch_referrer ILIKE '%mail.yahoo.com%'
            THEN 'Email'
          when ${TABLE}.last_touch_utm_medium ILIKE '%affiliate%'
          or ${TABLE}.last_touch_utm_source ILIKE '%pepperjam%'
            THEN 'Affiliate'
          when ${TABLE}.last_touch_utm_medium ILIKE '%display%'
          or ${TABLE}.last_touch_utm_source ILIKE '%gdn%'
          or ${TABLE}.last_touch_referrer ILIKE '%criteo%'
          or ${TABLE}.last_touch_referrer ILIKE '%googleads.g.doubleclick.net%'
          or ${TABLE}.last_touch_referrer ILIKE '%tpc.googlesyndication.com%'
            THEN 'Display'
          when (${TABLE}.last_touch_referrer ILIKE '%google%'
          or ${TABLE}.last_touch_referrer ILIKE '%bing%'
          or ${TABLE}.last_touch_referrer ILIKE '%yahoo%'
          or ${TABLE}.last_touch_referrer ILIKE '%msn%'
          or ${TABLE}.last_touch_referrer ILIKE '%ask%'
          or ${TABLE}.last_touch_referrer ILIKE '%baidu%'
          or ${TABLE}.last_touch_referrer ILIKE '%yandex%'
          or ${TABLE}.last_touch_referrer ILIKE '%duckduckgo%'
          )
          and ${TABLE}.last_touch_utm_medium IS NOT NULL
          or ${TABLE}.last_touch_landing_page ILIKE '%gclid=%'
          or ${TABLE}.last_touch_landing_page ILIKE '%msclkid=%'
            THEN 'Paid Search'
          when ${TABLE}.last_touch_utm_source ILIKE '%FBIG%'
          or (${TABLE}.last_touch_referrer ILIKE '%twitter.com%'
          or ${TABLE}.last_touch_referrer ILIKE '%linkedin.com%'
          or ${TABLE}.last_touch_referrer ILIKE '%lnkd.in%'
          or ${TABLE}.last_touch_referrer ILIKE '%reddit.com%'
          or ${TABLE}.last_touch_referrer ILIKE '%pinterest.com%'
          or ${TABLE}.last_touch_referrer ILIKE '%snapchat.com%'
          or ${TABLE}.last_touch_referrer ILIKE '%youtube.com%'
          ) and ${TABLE}.last_touch_utm_medium IS NOT NULL
          or ${TABLE}.last_touch_landing_page ILIKE '%fbaid=%'
          or ${TABLE}.last_touch_landing_page ILIKE '%licid=%'
            THEN 'Paid Social'
          when ${TABLE}.last_touch_referrer ILIKE '%google%'
          or ${TABLE}.last_touch_referrer ILIKE '%bing%'
          or ${TABLE}.last_touch_referrer ILIKE '%yahoo%'
          or ${TABLE}.last_touch_referrer ILIKE '%msn%'
          or ${TABLE}.last_touch_referrer ILIKE '%ask%'
          or ${TABLE}.last_touch_referrer ILIKE '%baidu%'
          or ${TABLE}.last_touch_referrer ILIKE '%yandex%'
          or ${TABLE}.last_touch_referrer ILIKE '%duckduckgo%'
            THEN 'Organic Search'
          when ${TABLE}.last_touch_referrer ILIKE '%twitter.com%'
          or ${TABLE}.last_touch_referrer ILIKE '%linkedin.com%'
          or ${TABLE}.last_touch_referrer ILIKE '%lnkd.in%'
          or ${TABLE}.last_touch_referrer ILIKE '%reddit.com%'
          or ${TABLE}.last_touch_referrer ILIKE '%pinterest.com%'
          or ${TABLE}.last_touch_referrer ILIKE '%snapchat.com%'
          or ${TABLE}.last_touch_referrer ILIKE '%youtube.com%'
            THEN 'Organic Social'
          when ${TABLE}.last_touch_utm_source ILIKE '%email%'
            THEN 'Email'
          when ${TABLE}.last_touch_utm_source ILIKE '%Friendbuy%'
            THEN 'Refer-A-Friend'
          when ${TABLE}.last_touch_utm_medium IS NOT NULL
            THEN 'Other Channel'
          when ${TABLE}.last_touch_referrer IS NULL
          or ${TABLE}.last_touch_referrer ILIKE '%android-app%'
          or ${TABLE}.last_touch_referrer ILIKE '%shethinx.com%'
          or ${TABLE}.last_touch_referrer ILIKE '%iconundies.com%'
            THEN 'Direct'
          when ${TABLE}.last_touch_referrer IS NOT NULL
            THEN 'Other Referral'
          ELSE 'Other Referral'
          END;;
  }

  dimension: first_touch_marketing_channel{
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
          or ${TABLE}.referrer ILIKE '%iconundies.com%'
            THEN 'Direct'
          when ${TABLE}.referrer IS NOT NULL
            THEN 'Other Referral'
          ELSE 'Other Referral'
          END;;
  }
}
