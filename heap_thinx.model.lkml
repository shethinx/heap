connection: "main_redshift_cluster"
# This block is mostly prebuilt
# Heap is also in the main thinx and icon models
label: "Thinx Heap Block"
# include all the views
include: "*.view"


# include all the dashboards
# include: "sessions_overview.dashboard"
# include: "referrer_dashboard.dashboard"
# include: "funnel_explorer.dashboard"
access_grant: analytics {
  user_attribute: department
  allowed_values: ["analytics"]
}

explore: all_events {
  required_access_grants: [analytics]
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
  required_access_grants: [analytics]
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

}

explore: funnel_explorer {
  required_access_grants: [analytics]
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
