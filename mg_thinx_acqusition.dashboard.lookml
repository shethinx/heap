- dashboard: mg_dashboards
  title: MG Dashboards
  layout: newspaper
  elements:
  - title: Monthly Session Count per Landing Page by Referrer
    name: Monthly Session Count per Landing Page by Referrer
    model: heap_block
    explore: sessions
    type: looker_column
    fields:
    - sessions.count_users
    - sessions.landing_page
    - sessions.source_we_defined
    pivots:
    - sessions.landing_page
    filters:
      sessions.session_week: 1 months
      sessions.count_users: ">500"
    sorts:
    - sessions.count_users desc 0
    - sessions.landing_page
    limit: 1000
    column_limit: 50
    stacking: normal
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    ordering: desc
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: positron
    map_position: fit_data
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    value_labels: legend
    label_type: labPer
    show_null_points: true
    point_style: circle
    interpolation: linear
    font_size: '12'
    series_types: {}
    hide_legend: true
    limit_displayed_rows_values:
      show_hide: hide
      first_last: last
      num_rows: 0
    row: 7
    col: 0
    width: 24
    height: 10
  - title: Weekly New User Sessions by utm Campaign -  International v Domestic
    name: Weekly New User Sessions by utm Campaign -  International v Domestic
    model: heap_block
    explore: sessions
    type: looker_line
    fields:
    - sessions.session_week
    - sessions.count_users
    - sessions.utm_campaign
    pivots:
    - sessions.utm_campaign
    filters:
      sessions.session_month: 12 weeks
      sessions.count_users: ">=500"
      sessions.utm_campaign: USA,international
      session_facts.is_first_session: 'Yes'
    sorts:
    - sessions.utm_campaign 0
    - sessions.session_week desc
    limit: 500
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: true
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: time
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    show_row_numbers: false
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '50'
    hide_legend: true
    row: 76
    col: 0
    width: 24
    height: 12
  - title: Weekly Returning User Sessions by utm Campaign -  International v Domestic
    name: Weekly Returning User Sessions by utm Campaign -  International v Domestic
    model: heap_block
    explore: sessions
    type: looker_line
    fields:
    - sessions.session_week
    - sessions.count_users
    - sessions.utm_campaign
    pivots:
    - sessions.utm_campaign
    filters:
      sessions.session_month: 12 weeks
      sessions.count_users: ">=500"
      sessions.utm_campaign: USA,international
      session_facts.is_first_session: 'No'
    sorts:
    - sessions.utm_campaign 0
    - sessions.session_week desc
    limit: 500
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: true
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: time
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    show_row_numbers: false
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '50'
    hide_legend: true
    row: 88
    col: 0
    width: 24
    height: 12
  - title: Organic User Sessions Per Week
    name: Organic User Sessions Per Week
    model: heap_block
    explore: sessions
    type: looker_area
    fields:
    - session_facts.is_first_session
    - sessions.count_users
    - sessions.session_week
    pivots:
    - session_facts.is_first_session
    fill_fields:
    - session_facts.is_first_session
    - sessions.session_week
    filters:
      sessions.session_date: 12 weeks
      sessions.referrer_domain_mapped: 'NULL'
    sorts:
    - sessions.session_week desc
    - session_facts.is_first_session
    limit: 500
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    ordering: none
    show_null_labels: false
    series_types: {}
    hidden_series: []
    series_labels:
      No - sessions.count_users: Returning
      Yes - sessions.count_users: New
    row: 0
    col: 0
    width: 12
    height: 7
  - title: Non-Organic User Sessions Per Week
    name: Non-Organic User Sessions Per Week
    model: heap_block
    explore: sessions
    type: looker_area
    fields:
    - session_facts.is_first_session
    - sessions.count_users
    - sessions.session_week
    pivots:
    - session_facts.is_first_session
    fill_fields:
    - session_facts.is_first_session
    - sessions.session_week
    filters:
      sessions.session_date: 12 weeks
      sessions.referrer_domain_mapped: "-NULL"
    sorts:
    - sessions.session_week desc
    - session_facts.is_first_session
    limit: 500
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    ordering: none
    show_null_labels: false
    series_types: {}
    hidden_series: []
    series_labels:
      No - sessions.count_users: Returning
      Yes - sessions.count_users: New
    row: 0
    col: 12
    width: 12
    height: 7
  - title: New User Sessions by utm Campaign in the past month
    name: New User Sessions by utm Campaign in the past month
    model: heap_block
    explore: sessions
    type: table
    fields:
    - sessions.count_users
    - sessions.utm_campaign
    filters:
      sessions.session_month: 1 months
      sessions.count_users: ">=100"
      sessions.utm_campaign: "-NULL,-all,-All,-USA,-international"
      session_facts.is_first_session: 'Yes'
    sorts:
    - sessions.count_users desc
    limit: 500
    show_view_names: true
    show_row_numbers: false
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: time
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '50'
    hide_legend: true
    row: 64
    col: 0
    width: 12
    height: 12
  - title: Returning User Sessions by utm Campaign in the past month
    name: Returning User Sessions by utm Campaign in the past month
    model: heap_block
    explore: sessions
    type: table
    fields:
    - sessions.count_users
    - sessions.utm_campaign
    filters:
      sessions.session_month: 1 months
      sessions.count_users: ">=100"
      sessions.utm_campaign: "-NULL,-all,-All,-USA,-international"
      session_facts.is_first_session: 'No'
    sorts:
    - sessions.count_users desc
    limit: 500
    show_view_names: true
    show_row_numbers: false
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: time
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '50'
    hide_legend: true
    row: 64
    col: 12
    width: 12
    height: 12
  - title: Daily User Sessions by utm Campaign - High Performing
    name: Daily User Sessions by utm Campaign - High Performing
    model: heap_block
    explore: sessions
    type: looker_column
    fields:
    - sessions.count_users
    - sessions.utm_campaign
    - sessions.session_date
    pivots:
    - sessions.utm_campaign
    filters:
      sessions.session_month: 1 months
      sessions.count_users: ">=300"
      sessions.utm_campaign: "-NULL,-all,-All,-USA,-international"
    sorts:
    - sessions.count_users desc 0
    - sessions.utm_campaign
    limit: 500
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: time
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_null_points: true
    point_style: none
    interpolation: linear
    barColors:
    - red
    - blue
    groupBars: true
    labelSize: 10pt
    showLegend: true
    show_row_numbers: false
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '50'
    hide_legend: true
    row: 52
    col: 0
    width: 24
    height: 12
  - title: Weekly User Sessions by Referrer and Landing Page - High Perfomring
    name: Weekly User Sessions by Referrer and Landing Page - High Perfomring
    model: heap_block
    explore: sessions
    type: looker_column
    fields:
    - sessions.session_week
    - sessions.count_users
    - sessions.landing_page
    - sessions.source_we_defined
    pivots:
    - sessions.landing_page
    - sessions.source_we_defined
    filters:
      sessions.session_month: 12 weeks
      sessions.count_users: ">=5000"
    sorts:
    - sessions.count_users desc 0
    - sessions.landing_page
    - sessions.source_we_defined
    limit: 500
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: true
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: time
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_null_points: true
    point_style: none
    interpolation: linear
    show_row_numbers: false
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '50'
    hide_legend: true
    row: 29
    col: 0
    width: 24
    height: 12
  - title: New User Sessions by Referrer and Landing Page in the past Month
    name: New User Sessions by Referrer and Landing Page in the past Month
    model: heap_block
    explore: sessions
    type: table
    fields:
    - sessions.count_users
    - sessions.landing_page
    - sessions.source_we_defined
    pivots:
    - sessions.source_we_defined
    filters:
      session_facts.is_first_session: 'Yes'
      sessions.session_month: 1 months
      sessions.count_users: ">=50"
    sorts:
    - sessions.source_we_defined 0
    - sessions.count_users desc 3
    limit: 500
    show_view_names: true
    show_row_numbers: false
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: time
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    ordering: none
    show_null_labels: false
    series_types: {}
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '50'
    hide_legend: true
    row: 17
    col: 0
    width: 12
    height: 12
  - title: Returning User Sessions by Referrer and Landing Page in the past Month
    name: Returning User Sessions by Referrer and Landing Page in the past Month
    model: heap_block
    explore: sessions
    type: table
    fields:
    - sessions.count_users
    - sessions.landing_page
    - sessions.source_we_defined
    pivots:
    - sessions.source_we_defined
    filters:
      session_facts.is_first_session: 'No'
      sessions.session_month: 1 months
      sessions.count_users: ">=20"
    sorts:
    - sessions.source_we_defined 0
    - sessions.count_users desc 3
    limit: 500
    show_view_names: true
    show_row_numbers: false
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: time
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    ordering: none
    show_null_labels: false
    series_types: {}
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '50'
    hide_legend: true
    row: 17
    col: 12
    width: 12
    height: 12
  - title: User Sessions by City (Domestic)
    name: User Sessions by City (Domestic)
    model: heap_block
    explore: sessions
    type: table
    fields:
    - sessions.count_users
    - sessions.city
    filters:
      sessions.session_month: 1 months
      sessions.count_users: ">=100"
      sessions.country: "%United States%"
      sessions.city: "-NULL"
    sorts:
    - sessions.count_users desc
    - sessions.city
    limit: 500
    show_view_names: true
    show_row_numbers: false
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: time
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '50'
    hide_legend: true
    row: 41
    col: 0
    width: 12
    height: 11
  - title: User Sessions by City (International)
    name: User Sessions by City (International)
    model: heap_block
    explore: sessions
    type: table
    fields:
    - sessions.count_users
    - sessions.city
    filters:
      sessions.session_month: 1 months
      sessions.count_users: ">=100"
      sessions.country: "-%United States%"
      sessions.city: "-NULL"
    sorts:
    - sessions.count_users desc
    - sessions.city
    limit: 500
    show_view_names: true
    show_row_numbers: false
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: time
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '50'
    hide_legend: true
    row: 41
    col: 12
    width: 12
    height: 11
