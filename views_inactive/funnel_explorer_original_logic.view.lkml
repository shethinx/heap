#View should not be used....old logic
# view: funnel_explorer_original_logic {
#   # Or, you could make this view a derived table, like this:
#   derived_table: {
#     sql:
#     with
#       heap_shopify_order_mapping as  (
#         SELECT
#           o.order_number
#           ,listagg(distinct case when oli.vendor = 'Thinx Underwear' then 'THINX' when vendor = 'MAS' then 'Speax'  else oli.vendor end,',')
#             WITHIN GROUP (ORDER BY case when oli.vendor = 'Thinx Underwear' then 'THINX' when vendor = 'MAS' then 'Speax'  else oli.vendor end)
#               as included_brands
#         FROM thinx_shopify.orders as o
#           LEFT JOIN orders__line_items  as oli
#             ON o.id = oli._sdc_source_key_id
#         GROUP BY 1
#       ),
#
#       unique_event_ids as (
#         select event_id
#         from heap_thinx.order_completed as oc
#           join heap_shopify_order_mapping  as om
#             on oc.order_id = om.order_number
#         where
#           {% if brand._parameter_value == "'ALL'" %} 1 = 1
#           {% else %} om.included_brands = {{ brand._parameter_value }} {% endif %}
#         ),
#
#       unique_session_ids as (
#         select distinct session_id
#         from heap_thinx.all_events
#         where
#           {% if brand._parameter_value == "'THINX'" %} event_table_name = 'thinx_pageviews_t_view_any_thinx_page'
#           {% elsif brand._parameter_value == "'Speax'" %} event_table_name = 'speax_pageviews_s_view_any_speax_page'
#           {% elsif brand._parameter_value == "'BTWN'" %} event_table_name = 'btwn_pageviews_b_view_any_btwn_page'
#           {% elsif brand._parameter_value == "'BTWN,THINX'" %} event_table_name IN ('btwn_pageviews_b_view_any_btwn_page','thinx_pageviews_t_view_any_thinx_page')
#           {% elsif brand._parameter_value == "'BTWN,Speax'" %} event_table_name IN ('btwn_pageviews_b_view_any_btwn_page','speax_pageviews_s_view_any_speax_page')
#           {% elsif brand._parameter_value == "'Speax,THINX'" %} event_table_name IN ('speax_pageviews_s_view_any_speax_page','thinx_pageviews_t_view_any_thinx_page')
#           {% else %} event_table_name IN ('thinx_pageviews_t_view_any_thinx_page','speax_pageviews_s_view_any_speax_page','btwn_pageviews_b_view_any_btwn_page') {% endif %}
#         )
#
#     SELECT all_events.session_id || '-' || all_events.user_id as session_unique_id
#         , MIN(all_events.time) as session_time
#         , MIN(
#             CASE WHEN
#               {% condition event1 %} all_events.event_table_name {% endcondition %}
#               THEN all_events.time
#               ELSE NULL END
#             ) as event1_time
#         , MIN(
#             CASE WHEN
#               {% condition event2 %} all_events.event_table_name {% endcondition %}
#               THEN all_events.time
#               ELSE NULL END
#             ) as event2_time
#         , MIN(
#             CASE WHEN
#               {% condition event3 %} all_events.event_table_name {% endcondition %}
#               THEN all_events.time
#               ELSE NULL END
#             ) as event3_time
#       FROM heap_thinx.all_events as all_events
#       WHERE {% condition sessions.session_date %} all_events.time {% endcondition %}
#       and
#       {% if all_order_completes_or_brand_specific_conversions._parameter_value == "'ALL'" %}
#        1=1
#       {% else %}  case when event_table_name = 'order_completed' then event_id in (select event_id from unique_event_ids) else 1=1 end {% endif %}
#       and
#       {% if all_page_views_or_brand_specific_conversions._parameter_value == "'ALL'" %}
#        1=1
#       {% else %}  case when event_table_name = 'pageviews' then session_id in (select session_id from unique_session_ids) else 1=1 end {% endif %}
#
#       GROUP BY 1
#        ;;
#   }
#
# #Commented out from original logic for else
# #  case when
# #
#   #   {% if brand._parameter_value == "'THINX'" %} event_table_name = 'thinx_pageviews_t_view_any_thinx_page'
#   #   {% elsif brand._parameter_value == "'Speax'" %} event_table_name = 'speax_pageviews_s_view_any_speax_page'
#   #   {% elsif brand._parameter_value == "'BTWN'" %} event_table_name = 'btwn_pageviews_b_view_any_btwn_page'
#   #   {% elsif brand._parameter_value == "'BTWN,THINX'" %} event_table_name IN ('btwn_pageviews_b_view_any_btwn_page','thinx_pageviews_t_view_any_thinx_page')
#   #   {% elsif brand._parameter_value == "'BTWN,Speax'" %} event_table_name IN ('btwn_pageviews_b_view_any_btwn_page','speax_pageviews_s_view_any_speax_page')
#   #   {% elsif brand._parameter_value == "'Speax,THINX'" %} event_table_name IN ('speax_pageviews_s_view_any_speax_page','thinx_pageviews_t_view_any_thinx_page')
#   #   {% else %} event_table_name IN ('thinx_pageviews_t_view_any_thinx_page','speax_pageviews_s_view_any_speax_page','btwn_pageviews_b_view_any_btwn_page') {% endif %}
#
#   # then session_id in (select session_id from unique_session_ids) else 1=1 end
#
#   filter: event1 {
#     suggest_explore: all_events
#     suggest_dimension: all_events.event_name
#   }
#
#   filter: event2 {
#     suggest_explore: all_events
#     suggest_dimension: all_events.event_name
#   }
#
#   filter: event3 {
#     suggest_explore: all_events
#     suggest_dimension: all_events.event_name
#   }
#
#   filter: event_time {
#     type: date_time
#   }
#
#   parameter: brand {
#     type: string
#     allowed_value: {
#       value: "THINX"
#     }
#     allowed_value: {
#       value: "Speax"
#     }
#     allowed_value: {
#       value: "BTWN"
#     }
#     allowed_value: {
#       value: "BTWN,THINX"
#     }
#     allowed_value: {
#       value: "BTWN,Speax"
#     }
#     allowed_value: {
#       value: "Speax,THINX"
#     }
#     allowed_value: {
#       value: "ALL"
#     }
#   }
#
#   parameter: all_order_completes_or_brand_specific_conversions {
#     description: "Selecting ALL indicates all orders placed with ANY of the three brands will be used. A brand specific selection will filter the orders to only include orders that contain the brand as selected in the Brand filter."
#     type: string
#     allowed_value: {
#       value: "Brand Specific"
#     }
#     allowed_value: {
#       value: "ALL"
#     }
#   }
#
#   parameter: all_page_views_or_brand_specific_conversions {
#     description: "Use this in conjuntion with the event type pageviews. Selecting ALL indicates every session will be considered regardless of the individual brand pages visited. A brand specific selection will filter the session to to
#     only sessions that contain at least 1 page visited from the brand as selected in the Brand filter. This has the same effect as explicitly selecting: btwn_pageviews_b_view_any_btwn_page, speax_pageviews_s_view_any_speax_page or  thinx_pageviews_t_view_any_thinx_page,  "
#     type: string
#     allowed_value: {
#       value: "Brand Specific"
#     }
#     allowed_value: {
#       value: "ALL"
#     }
#   }
#
#   dimension_group: session {
#     hidden:  yes
#     type: time
#     sql: ${TABLE}.session_time ;;
#     timeframes: [date, month, week, year]
#   }
#
#   dimension: session_unique_id {
#     type: string
#     primary_key: yes
#     sql: ${TABLE}.session_unique_id ;;
#   }
#
#   dimension_group: event1 {
#     type: time
#     timeframes: [time]
#     sql: ${TABLE}.event1_time ;;
#   }
#
#   dimension_group: event2 {
#     type: time
#     timeframes: [time]
#     sql: ${TABLE}.event2_time ;;
#   }
#
#   dimension_group: event3 {
#     type: time
#     timeframes: [time]
#     sql: ${TABLE}.event3_time ;;
#   }
#
#   dimension: event1_before_event2 {
#     type: yesno
#     sql: ${event1_time} < ${event2_time} ;;
#     hidden: yes
#   }
#
#   dimension: event2_before_event3 {
#     type: yesno
#     sql: ${event2_time} < ${event3_time} ;;
#     hidden: yes
#   }
#
#   measure: count_sessions {
#     type: count_distinct
#     sql: ${session_unique_id} ;;
#   }
#
#   measure: count_sessions_event1 {
#     type: count_distinct
#     sql: ${session_unique_id} ;;
#     drill_fields: [session_unique_id]
#     filters: {
#       field: event1_time
#       value: "NOT NULL"
#     }
#   }
#
#   measure: count_sessions_event12 {
#     type: count_distinct
#     sql: ${session_unique_id} ;;
#
#     filters: {
#       field: event1_time
#       value: "NOT NULL "
#     }
#
#     filters: {
#       field: event2_time
#       value: "NOT NULL"
#     }
#
#     filters: {
#       field: event1_before_event2
#       value: "Yes"
#     }
#   }
#
#   measure: count_sessions_event123 {
#     type: count_distinct
#     sql: ${session_unique_id} ;;
#
#     filters: {
#       field: event1_time
#       value: "NOT NULL"
#     }
#
#     filters: {
#       field: event2_time
#       value: "NOT NULL"
#     }
#
#     filters: {
#       field: event3_time
#       value: "NOT NULL"
#     }
#
#     filters: {
#       field: event1_before_event2
#       value: "Yes"
#     }
#
#     filters: {
#       field: event2_before_event3
#       value: "Yes"
#     }
#   }
#
#   measure: conversion_rate_event_1 {
#     description: "Percent of Total Sessions that Convert to Event 1"
#     type: number
#     sql: 100*(${count_sessions_event1}::float/NULLIF(${count_sessions},0)) ;;
#     value_format: "0.00\%"
#   }
#
#   measure: conversion_rate_event_2 {
#     description: "Percent of Total Sessions that Convert to Event 1 and 2"
#     type: number
#     sql: 100*(${count_sessions_event12}::float/NULLIF(${count_sessions},0)) ;;
#     value_format: "0.00\%"
#   }
#
#   measure: conversion_rate_event_1_to_2 {
#     description: "Percent of Sessions with Event 1 that convert to Event 2"
#     type: number
#     sql: 100*(${count_sessions_event12}::float/NULLIF(${count_sessions_event1},0)) ;;
#     value_format: "0.00\%"
#   }
#
#   measure: conversion_rate_event_3 {
#     description: "Percent of Total Sessions that Convert to Event 1, 2, and 3"
#     type: number
#     sql: 100*(${count_sessions_event123}::float/NULLIF(${count_sessions},0)) ;;
#     value_format: "0.00\%"
#   }
#
#   measure: conversion_rate_event_1_and_2_to_3 {
#     description: "Percent of Sessions with Event 1 and 2 that convert to Event 3"
#     type: number
#     sql: 100*(${count_sessions_event12}::float/NULLIF(${count_sessions_event1},0)) ;;
#     value_format: "0.00\%"
#   }
# }
