connection: "main_redshift_cluster"
# This block is mostly prebuilt
# Heap is also in the main thinx and icon models
label: "Thinx Heap Block"
# include all the views
include: "*.view"

case_sensitive: no

# include all the dashboards
# include: "sessions_overview.dashboard"
# include: "referrer_dashboard.dashboard"
# include: "funnel_explorer.dashboard"
access_grant: executive {
  user_attribute: department
  allowed_values: ["executive", "analytics"]
}

datagroup: heap_refresh {
  sql_trigger:  SELECT FLOOR(EXTRACT(epoch from GETDATE()) / (6*60*60)) ;; #refresh every 6 hours
}

persist_with: heap_refresh

explore: all_events {
  fields: [ALL_FIELDS*, -sessions.percentage_of_sessions_with_pdp]
  required_access_grants: [executive]
  join: users {
    type: left_outer
    sql_on: ${all_events.user_id} = ${users.user_id} ;;
    relationship: many_to_one
  }

  join: sessions {
    type: left_outer
    sql_on: ${all_events.session_unique_id} = ${sessions.session_unique_id} ;;
    relationship: many_to_one
  }

  join: session_facts {
    type: left_outer
    sql_on: ${sessions.session_unique_id} = ${session_facts.session_unique_id} ;;
    relationship: one_to_one
  }

  join: event_flow {
    sql_on: ${all_events.unique_event_id} = ${event_flow.unique_event_id} ;;
    relationship: one_to_one
  }
}

explore: sessions {
  required_access_grants: [executive]
  join: users {
    type: left_outer
    sql_on: ${sessions.user_id} = ${users.user_id} ;;
    relationship: many_to_one
  }

  join: user_facts {
    type: left_outer
    sql_on: ${sessions.user_id} = ${user_facts.user_id} ;;
    relationship: many_to_one
  }

  join: session_facts {
    type: left_outer
    sql_on: ${sessions.session_unique_id} = ${session_facts.session_unique_id} ;;
    relationship: one_to_one
  }

  join: heap_orders_sales_summary_ndt {
    view_label: "Shopify Order Information"
    type: left_outer
    sql_on: ${sessions.session_id} = ${heap_orders_sales_summary_ndt.session_id} ;;
    relationship: one_to_one
  }

  join: pageviews {
    type: left_outer
    sql_on: ${sessions.session_id} = ${pageviews.session_id} ;;
    relationship: one_to_many
  }

  join: leader_codes {
    type: left_outer
    relationship: many_to_one
    sql_on: ${pageviews.title} ilike '%' || ${leader_codes.leader_name} || '%' ;;
  }

  join: heap_orders_leader_sales_summary_ndt {
    view_label: "Leader Codes"
    type: left_outer
    relationship: many_to_one
    sql_on: ${sessions.session_date} = ${heap_orders_leader_sales_summary_ndt.created_date} and ${leader_codes.discount_code} = ${heap_orders_leader_sales_summary_ndt.discount_code} ;;
  }

  join: pageviews_first {
    view_label: "Pageviews Summary"
    type: left_outer
    sql_on: ${sessions.session_id} = ${pageviews_first.session_id} ;;
    relationship: one_to_one
  }

  join: pageviews_summary {
    type: left_outer
    sql_on: ${sessions.session_id} = ${pageviews_summary.session_id} ;;
    relationship: one_to_one
  }

  join: sendgrid_summary {
    type: full_outer
    sql_on: ${sessions.utm_content_part_4} = ${sendgrid_summary.marketing_campaign_id} and ${sessions.session_date} = ${sendgrid_summary.event_date}
    and ${sessions.utm_source_clean} = 'Sendgrid' ;;
    relationship: many_to_one
  }

}

explore: sendgrid_events {
  group_label: "Thinx Marketing"
  label: "Sendgrid Campaigns"

}

explore: pageviews {}

explore: funnel_explorer {
  fields: [ALL_FIELDS*, -sessions.percentage_of_sessions_with_pdp]
  always_filter: {
    filters: {
      field: brand
    }
      filters: {
        field: all_order_completes_or_brand_specific_conversions
        value: "ALL"
      }
    filters: {
      field: all_page_views_or_brand_specific_conversions
      value: "ALL"
    }
  }
  join: sessions {
    type: left_outer
    sql_on: ${funnel_explorer.session_unique_id} = ${sessions.session_unique_id} ;;
    relationship: one_to_one
  }

  join: session_facts {
    type: left_outer
    sql_on: ${sessions.session_unique_id} = ${session_facts.session_unique_id} ;;
    relationship: one_to_one
  }
}

explore: pageviews_summary_leader {
  hidden: yes
  #used just to generate table for use in main thinx explore
}
