view: pps_answers_conversion {
  derived_table: {
    sql:
    with pps_users as(
    select
    user_id,
    pps_initial_referrer,
    webhook_initial_referrer,
    email,
    joindate
    from heap_thinx.users
    where pps_initial_referrer is not null),

    pps as(
    select *
    from pps_users left join post_purchase_survey.questions using(email)),

    all_sessions_pps as(
    select
    sessions.user_id,
    sessions.session_id,
    sessions.time,
    sessions.referrer,
    sessions.landing_page,
    sessions.utm_source,
    sessions.utm_medium,
    joindate,
    row_number() over( partition by sessions.user_id order by min(sessions.time)) as session_sequence_number
    from pps left join heap_thinx.sessions on sessions.user_id = pps.user_id
    group by 1,2,3,4,5,6,7,8),

    first_session_pps as(
    select
    user_id,
    referrer,
    landing_page,
    utm_source,
    utm_medium,
    time
    from all_sessions_pps where session_sequence_number = 1),
    order_completed as(
    select
    order_completed.user_id,
    order_completed.time as order_time,
    order_completed.session_id,
    order_completed.revenue,
    order_completed.marketing_channel as last_touch_marketing_channel,
    first_session_pps.referrer as referrer,
    first_session_pps.landing_page as landing_page,
    first_session_pps.utm_source as utm_source,
    first_session_pps.utm_medium as utm_medium,
    first_session_pps.time as first_touch_time,
    datediff('day', joindate, order_time) as time_between_first_and_last_touch,
    a.session_sequence_number
    from heap_thinx.order_completed left join all_sessions_pps as a on order_completed.session_id = a.session_id
    left join first_session_pps on order_completed.user_id = first_session_pps.user_id)


    select
    distinct
    *
    From pps left join order_completed using(user_id)
    ;;
  }

  measure: count {
    type: count
  }

  dimension: self_reported_attribution {
    type: string
    sql: ${TABLE}.pps_initial_referrer ;;
  }

  measure: average_touches_to_convert {
    type: median
    sql: ${TABLE}.session_sequence_number ;;
  }

  measure: average_time_to_convert {
    type: median
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
          When ${TABLE}.last_touch_marketing_channel is null then 'Direct'
          else ${TABLE}.last_touch_marketing_channel
          End;;
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
            THEN 'Unknown Channel'
          when ${TABLE}.referrer IS NULL
          or ${TABLE}.referrer ILIKE '%android-app%'
          or ${TABLE}.referrer ILIKE '%shethinx.com%'
            THEN 'Direct'
          when ${TABLE}.referrer IS NOT NULL
            THEN 'Other Referral'
          ELSE 'Other Referral'
          END;;
  }

  dimension: q10_podcasts {
    label: "What kind of podcasts do you listen to?"
    type: string
    sql: ${TABLE}.q10_podcasts ;;
  }

  dimension: q11_exercise {
    label: "What sports or exercises do you like to do?"
    type: string
    sql: ${TABLE}.q11_exercise ;;
  }

  dimension: q12_pairs_ruined {
    label: "How many pairs of regular underwear has Aunt Flo destroyed?"
    type: string
    sql: ${TABLE}.q12_pairs_ruined ;;
  }

  dimension: q15_phone_number {
    label: "Phone Number"
    type: string
    sql: ${TABLE}.q15_phone_number ;;
  }


  dimension: q16 {
    label: "IP Address"
    type: string
    sql: ${TABLE}.q16 ;;
  }

  dimension: q18_nps {
    label: "How likely would you be to recommend THINX to a friend?"
    type: number
    sql: ${TABLE}.q18_nps ;;
  }

  dimension: q19_kids {
    label: "Do you have any kids? (How many)"
    type: number
    sql: ${TABLE}.q19_kids ;;
  }


  dimension: q20_last_period_start_date {
    label: "Last day your period began"
    type: number
    sql: ${TABLE}.q20_last_period_start_date ;;
  }


  dimension_group: q22_birthday {
    label: "When is your birthday?"
    type: time
    sql: ${TABLE}.q22_birthday ;;
  }

  dimension: q23_how_many_pairs {
    label: "How many pairs of THINX do you own?"
    type: number
    sql: ${TABLE}.q23_how_many_pairs ;;
  }

  dimension_group: q24_last_period {
    label: "Typically, how many days from start date to start date for each of your cycles?"
    type: time
    sql: ${TABLE}.q24_last_period ;;
  }



  dimension: q5_how_long_to_buy {
    label: "How long did you take to consider buying THINX?"
    type: string
    sql: ${TABLE}.q5_how_long_to_buy ;;
  }

  dimension: q6_blog {
    label:"What are your favorite sections of our blog?"
    type: string
    sql: ${TABLE}.q6_blog ;;
  }

  dimension: q8_first_time {
    label: "What convinced you to try THINX for the first time?"
    type: string
    sql: ${TABLE}.q8_first_time ;;
  }

  dimension_group: updated_at {
    label: "Survey Completed Date"
    type: time
    sql: ${TABLE}.updated_at ;;
  }

  dimension: q27_fit {
    label: "How would you rate the fit of THINX overall? (5 being the best)"
    type: number
    sql: ${TABLE}.q27_fit ;;
  }

  dimension: q26_competitors {
    label: "What other brands of underwear do you wear?"
    type: string
    sql: ${TABLE}.q26_competitors ;;
  }

  dimension: q17_flow_type {
    label: "How heavy is your flow?"
    type: string
    sql: ${TABLE}.q17_flow_type ;;
  }

  dimension: q9_favorite {
    label: "What is your favorite style of THINX?"
    type: string
    sql: ${TABLE}.q9_favorite ;;
  }

  dimension: q25_manage {
    label: "What do you currently use to manage your period?"
    type: string
    sql: ${TABLE}.q25_manage ;;
  }

  dimension: q28_comments {
    label: "Any additional comments you'd like to share?"
    type: string
    sql: ${TABLE}.q28_comments ;;
  }



  dimension: competitors_victorias_secret {
    label: "Victoria's Secret"
    type: yesno
    sql: ${TABLE}.q26_competitors ILIKE '%victorias_secret%' ;;
  }

  measure: count_victorias_secret {
    label: "Victoria's Secret"
    type: number
    sql: SUM(CASE when ${competitors_victorias_secret} then 1 else 0 end) ;;
  }

  dimension: competitors_ck {
    label: "CK"
    type: yesno
    sql: ${TABLE}.q26_competitors ILIKE '%ck%' ;;
  }

  measure: count_ck {
    label: "CK"
    type: number
    sql: SUM(CASE when ${competitors_ck} then 1 else 0 end) ;;
  }

  dimension: competitors_hanes {
    label: "Hanes"
    type: yesno
    sql: ${TABLE}.q26_competitors ILIKE '%hanes%' ;;
  }

  measure: count_hanes {
    label: "Hanes"
    type: number
    sql: SUM(CASE when ${competitors_hanes} then 1 else 0 end) ;;
  }

  dimension: competitors_pink {
    label: "Pink"
    type: yesno
    sql: ${TABLE}.q26_competitors ILIKE '%pink%' ;;
  }

  measure: count_pink {
    label: "Pink"
    type: number
    sql: SUM(CASE when ${competitors_pink} then 1 else 0 end) ;;
  }

  dimension: competitors_jockey {
    label: "Jockey"
    type: yesno
    sql: ${TABLE}.q26_competitors ILIKE '%jockey%' ;;
  }

  measure: count_jockey {
    label: "Jockey"
    type: number
    sql: SUM(CASE when ${competitors_jockey} then 1 else 0 end) ;;
  }

  measure: count_tampons {
    label: "Tampons"
    type: number
    sql: SUM(CASE when ${TABLE}.q25_manage ILIKE '%tampons%' then 1 else 0 end) ;;
  }

  measure: count_cups {
    label: "Cups"
    type: number
    sql: SUM(CASE when ${TABLE}.q25_manage ILIKE '%cups%' then 1 else 0 end) ;;
  }

  measure: count_disposeable_pads {
    label: "Disposable Pads"
    type: number
    sql: SUM(CASE when ${TABLE}.q25_manage ILIKE '%disposable-pads%' then 1 else 0 end) ;;
  }

  measure: count_reusable_pads {
    label: "Reusable Pads"
    type: number
    sql: SUM(CASE when ${TABLE}.q25_manage ILIKE '%reuseable-pads%' then 1 else 0 end) ;;
  }

  measure: count_liners {
    label: "Liners"
    type: number
    sql: SUM(CASE when ${TABLE}.q25_manage ILIKE '%liners%' then 1 else 0 end) ;;
  }

}
