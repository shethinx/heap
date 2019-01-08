connection: "icon_redshift_cluster"
# This block is mostly prebuilt
# Heap is also in the main thinx and icon models
label: "Icon Heap"

# include all the views
include: "*.view"

# include all the dashboards

access_grant: marketing {
  user_attribute: department
  allowed_values: ["marketing"]
}

access_grant: analytics {
  user_attribute: department
  allowed_values: ["analytics"]
}

explore: all_events_icon {
  required_access_grants: [marketing, analytics]
  join: users_icon {
    type: left_outer
    sql_on: ${all_events_icon.user_id} = ${users_icon.user_id} ;;
    relationship: many_to_one
  }

  join: sessions_icon {
    type: left_outer
    sql_on: ${all_events_icon.session_unique_id} = ${sessions_icon.session_unique_id} ;;
    relationship: many_to_one
  }

  join: session_facts_icon {
    type: left_outer
    sql_on: ${sessions_icon.session_unique_id} = ${session_facts_icon.session_unique_id} ;;
    relationship: one_to_one
  }

  join: event_flow_icon {
    sql_on: ${all_events_icon.unique_event_id} = ${event_flow_icon.unique_event_id} ;;
    relationship: one_to_one
  }
}


explore: sessions_icon {
  required_access_grants: [marketing, analytics]
  join: users {
    type: left_outer
    sql_on: ${sessions_icon.user_id} = ${users.user_id} ;;
    relationship: many_to_one
  }

  join: user_facts_icon {
    type: left_outer
    sql_on: ${sessions_icon.user_id} = ${user_facts_icon.user_id} ;;
    relationship: many_to_one
  }

  join: session_facts_icon {
    type: left_outer
    sql_on: ${sessions_icon.session_unique_id} = ${session_facts_icon.session_unique_id} ;;
    relationship: one_to_one
  }

}


explore: funnel_explorer_icon {
  required_access_grants: [marketing, analytics]
  join: sessions_icon {
    type: left_outer
    sql_on: ${funnel_explorer_icon.session_unique_id} = ${sessions_icon.session_unique_id} ;;
    relationship: one_to_one
  }

  join: session_facts_icon {
    type: left_outer
    sql_on: ${sessions_icon.session_unique_id} = ${session_facts_icon.session_unique_id} ;;
    relationship: one_to_one
  }
}
