connection: "icon_redshift_cluster"
# This block is mostly prebuilt
# Heap is also in the main thinx and icon models
label: "Icon Heap Block"
# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

explore: all_events {
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
    view_label: "Sessions"
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
  label: "Icon Sessions 2?"
  }

explore: sessions_icon {
  label: "Icon Sessions"
  join: users {
    type: left_outer
    sql_on: ${sessions_icon.user_id} = ${users.user_id} ;;
    relationship: many_to_one
  }

  join: user_facts {
    view_label: "Users"
    type: left_outer
    sql_on: ${sessions_icon.user_id} = ${user_facts.user_id} ;;
    relationship: many_to_one
  }

  join: session_facts {
    view_label: "Sessions"
    type: left_outer
    sql_on: ${sessions_icon.session_unique_id} = ${session_facts.session_unique_id} ;;
    relationship: one_to_one
  }

}

explore: funnel_explorer {
  join: sessions {
    type: left_outer
    sql_on: ${funnel_explorer.session_unique_id} = ${sessions.session_unique_id} ;;
    relationship: one_to_one
  }

  join: session_facts {
    view_label: "Sessions"
    type: left_outer
    sql_on: ${sessions.session_unique_id} = ${session_facts.session_unique_id} ;;
    relationship: one_to_one
  }
}
