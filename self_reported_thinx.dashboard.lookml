- dashboard: mg__thinx_touchpoints_pps
  title: MG - THINX Touchpoints - PPS
  layout: newspaper
  elements:
  - title: Distribution of users across First Touch marketing Channel
    name: Distribution of users across First Touch marketing Channel
    model: heap_thinx
    explore: pps_answers_conversion
    type: looker_pie
    fields:
    - pps_answers_conversion.first_touch_marketing_channel
    - pps_answers_conversion.count
    sorts:
    - pps_answers_conversion.first_touch_marketing_channel
    limit: 500
    value_labels: labels
    label_type: labPer
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    point_style: none
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
    x_axis_reversed: false
    y_axis_reversed: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    listen:
      Order Date Filter: pps_answers_conversion.order_time_year
      Self Reported Attribution: pps_answers_conversion.self_reported_attribution
    row: 6
    col: 0
    width: 11
    height: 8
  - title: Distribution of users across Last Touch marketing Channel
    name: Distribution of users across Last Touch marketing Channel
    model: heap_thinx
    explore: pps_answers_conversion
    type: looker_pie
    fields:
    - pps_answers_conversion.count
    - pps_answers_conversion.last_touch_marketing_channel
    sorts:
    - pps_answers_conversion.last_touch_marketing_channel
    limit: 500
    value_labels: labels
    label_type: labPer
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    point_style: none
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
    x_axis_reversed: false
    y_axis_reversed: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    listen:
      Order Date Filter: pps_answers_conversion.order_time_year
      Self Reported Attribution: pps_answers_conversion.self_reported_attribution
    row: 6
    col: 13
    width: 11
    height: 8
  - title: Average number of Touchpoints before Purchase
    name: Average number of Touchpoints before Purchase
    model: heap_thinx
    explore: pps_answers_conversion
    type: single_value
    fields:
    - pps_answers_conversion.average_touches_to_convert
    limit: 500
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    point_style: none
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
    x_axis_reversed: false
    y_axis_reversed: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    listen:
      Order Date Filter: pps_answers_conversion.order_time_year
      Self Reported Attribution: pps_answers_conversion.self_reported_attribution
    row: 0
    col: 4
    width: 8
    height: 6
  - title: Average number of days between First Touch and Purchase
    name: Average number of days between First Touch and Purchase
    model: heap_thinx
    explore: pps_answers_conversion
    type: single_value
    fields:
    - pps_answers_conversion.average_time_to_convert
    limit: 500
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    point_style: none
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
    x_axis_reversed: false
    y_axis_reversed: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    listen:
      Order Date Filter: pps_answers_conversion.order_time_year
      Self Reported Attribution: pps_answers_conversion.self_reported_attribution
    row: 0
    col: 12
    width: 8
    height: 6
  - title: Average number of Touches to Convert by First Touch Marketing Channel
    name: Average number of Touches to Convert by First Touch Marketing Channel
    model: heap_thinx
    explore: pps_answers_conversion
    type: looker_column
    fields:
    - pps_answers_conversion.average_touches_to_convert
    - pps_answers_conversion.first_touch_marketing_channel
    pivots:
    - pps_answers_conversion.first_touch_marketing_channel
    sorts:
    - pps_answers_conversion.first_touch_marketing_channel
    limit: 500
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    point_style: none
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
    x_axis_reversed: false
    y_axis_reversed: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_null_points: true
    interpolation: linear
    series_types: {}
    listen:
      Order Date Filter: pps_answers_conversion.order_time_year
      Self Reported Attribution: pps_answers_conversion.self_reported_attribution
    row: 14
    col: 0
    width: 24
    height: 9
  - title: Average Days to Convert by First Touch Marketing Channel
    name: Average Days to Convert by First Touch Marketing Channel
    model: heap_thinx
    explore: pps_answers_conversion
    type: looker_column
    fields:
    - pps_answers_conversion.first_touch_marketing_channel
    - pps_answers_conversion.average_time_to_convert
    pivots:
    - pps_answers_conversion.first_touch_marketing_channel
    sorts:
    - pps_answers_conversion.first_touch_marketing_channel
    limit: 500
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    point_style: none
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
    x_axis_reversed: false
    y_axis_reversed: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_null_points: true
    interpolation: linear
    series_types: {}
    listen:
      Order Date Filter: pps_answers_conversion.order_time_year
      Self Reported Attribution: pps_answers_conversion.self_reported_attribution
    row: 23
    col: 0
    width: 24
    height: 9
  - title: Average Days to Convert by Last Touch Marketing Channel
    name: Average Days to Convert by Last Touch Marketing Channel
    model: heap_thinx
    explore: pps_answers_conversion
    type: looker_column
    fields:
    - pps_answers_conversion.last_touch_marketing_channel
    - pps_answers_conversion.average_time_to_convert
    pivots:
    - pps_answers_conversion.last_touch_marketing_channel
    filters:
      pps_answers_conversion.order_time_date: 12 months
    sorts:
    - pps_answers_conversion.last_touch_marketing_channel 0
    limit: 500
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    point_style: none
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
    x_axis_reversed: false
    y_axis_reversed: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_null_points: true
    interpolation: linear
    series_types: {}
    listen:
      Order Date Filter: pps_answers_conversion.order_time_year
      Self Reported Attribution: pps_answers_conversion.self_reported_attribution
    row: 41
    col: 0
    width: 24
    height: 9
  - title: Average number of Touches to Convert by Last Touch Marketing Channel
    name: Average number of Touches to Convert by Last Touch Marketing Channel
    model: heap_thinx
    explore: pps_answers_conversion
    type: looker_column
    fields:
    - pps_answers_conversion.average_touches_to_convert
    - pps_answers_conversion.last_touch_marketing_channel
    pivots:
    - pps_answers_conversion.last_touch_marketing_channel
    filters:
      pps_answers_conversion.order_time_date: 12 months
    sorts:
    - pps_answers_conversion.last_touch_marketing_channel 0
    limit: 500
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    point_style: none
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
    x_axis_reversed: false
    y_axis_reversed: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_null_points: true
    interpolation: linear
    series_types: {}
    listen:
      Order Date Filter: pps_answers_conversion.order_time_year
      Self Reported Attribution: pps_answers_conversion.self_reported_attribution
    row: 32
    col: 0
    width: 24
    height: 9
  - name: Post Purchase Survey
    type: text
    title_text: Post Purchase Survey
    row: 50
    col: 9
    width: 8
    height: 6
  filters:
  - name: Order Date Filter
    title: Order Date Filter
    type: field_filter
    default_value: 1 years
    allow_multiple_values: true
    required: false
    model: heap_thinx
    explore: pps_answers_conversion
    listens_to_filters: []
    field: pps_answers_conversion.order_time_year
  - name: Self Reported Attribution
    title: Self Reported Attribution
    type: field_filter
    default_value: social
    allow_multiple_values: true
    required: false
    model: heap_thinx
    explore: pps_answers_conversion
    listens_to_filters: []
    field: pps_answers_conversion.self_reported_attribution
