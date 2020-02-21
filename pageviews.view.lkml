view: pageviews {
  sql_table_name: heap_thinx.pageviews ;;

  dimension: pk {
    primary_key: yes
    type: string
    sql: ${event_id} || '|' || ${session_id} || '|' || ${user_id} ;;
  }

  dimension: path {
    type: string
    sql: lower(${TABLE}.path) ;;
  }

  dimension: path_page_type {
    case: {
      when: {
        label: "Thinx"
        sql: ${path} like '%thinx%' OR ${path} = 'www.shethinx.com/' ;;
      }
      when: {
        label: "Speax"
        sql: ${path} like '%speax%' ;;
      }
      when: {
        label: "BTWN"
        sql: ${path} like '%btwn%'  ;;
      }
      when: {
        label: "Blogs"
        sql: ${path} like '%blogs%'  ;;
      }
      when: {
        label: "Orders"
        sql: ${path} like '%orders%'  ;;
      }
      when: {
        label: "Account"
        sql: ${path} like '%account%'  ;;
      }
      when: {
        label: "Leader"
        sql: ${path} like '%leader%'  ;;
      }
      when: {
        label: "Cart"
        sql: ${path} like '%btwn%'  ;;
      }
      else: "Other"
    }
  }

  dimension: thinx_page_touch {
    group_label: "Page Type"
    type: yesno
    sql: ${path} like '%thinx%' OR ${path} = 'www.shethinx.com/' ;;
  }

  dimension: speax_page_touch {
    group_label: "Page Type"
    type: yesno
    sql: ${path} like '%speax%' ;;
  }

  dimension: btwn_page_touch {
    group_label: "Page Type"
    type: yesno
    sql: ${path} like '%btwn%' ;;
  }

  dimension: blog_page_touch {
    group_label: "Page Type"
    type: yesno
    sql: ${path} like '%blogs%' ;;
  }

  dimension: order_page_touch {
    group_label: "Page Type"
    type: yesno
    sql: ${path} like '%orders%' ;;
  }

  dimension: account_page_touch {
    group_label: "Page Type"
    type: yesno
    sql: ${path} like '%account%' ;;
  }

  dimension: leader_page_touch {
    group_label: "Page Type"
    type: yesno
    sql: ${path} like '%leader-%' ;;
  }

  dimension: cart_page_touch {
    group_label: "Page Type"
    type: yesno
    sql: ${path} like '%cart%' ;;
  }

  dimension: thinx_product_page_touch {
    group_label: "Page Type"
    type: yesno
    sql: ${path} like '%products/thinx%' or ${path} like '%collections/thinx%' ;;
  }

  dimension: speax_product_page_touch {
    group_label: "Page Type"
    type: yesno
    sql: ${path} like '%products/speax%' or ${path} like '%collections/speax%';;
  }

  dimension: btwn_product_page_touch {
    group_label: "Page Type"
    type: yesno
    sql: ${path} like '%products/btwn%' or ${path} like '%collections/btwn%';;
  }

  dimension: checkout_page_touch {
    group_label: "Page Type"
    type: yesno
    sql: ${path} like '%checkouts%' or ${path} like '%checkouts%';;
  }

  measure: count_of_thinx_pages_touched {
    group_label: "Page Type"
    type: count
    filters: {
      field: thinx_page_touch
      value: "Yes"
    }
  }

  measure: count_of_speax_pages_touched {
    group_label: "Page Type"
    type: count
    filters: {
      field: speax_page_touch
      value: "Yes"
    }
  }

  measure: count_of_btwn_pages_touched {
    group_label: "Page Type"
    type: count
    filters: {
      field: btwn_page_touch
      value: "Yes"
    }
  }

  measure: count_of_blog_pages_touched {
    group_label: "Page Type"
    type: count
    filters: {
      field: blog_page_touch
      value: "Yes"
    }
  }

  measure: count_of_order_pages_touched {
    group_label: "Page Type"
    type: count
    filters: {
      field: order_page_touch
      value: "Yes"
    }
  }

  measure: count_of_account_pages_touched {
    group_label: "Page Type"
    type: count
    filters: {
      field: account_page_touch
      value: "Yes"
    }
  }

  measure: count_of_leader_pages_touched {
    group_label: "Page Type"
    type: count
    filters: {
      field: leader_page_touch
      value: "Yes"
    }
  }

  measure: count_of_cart_pages_touched {
    group_label: "Page Type"
    type: count
    filters: {
      field: cart_page_touch
      value: "Yes"
    }
  }

  measure: count_of_thinx_product_pages_touched {
    group_label: "Page Type"
    type: count
    filters: {
      field: thinx_product_page_touch
      value: "Yes"
    }
  }

  measure: count_of_btwn_product_pages_touched {
    group_label: "Page Type"
    type: count
    filters: {
      field: btwn_product_page_touch
      value: "Yes"
    }
  }

  measure: count_of_speax_product_pages_touched {
    group_label: "Page Type"
    type: count
    filters: {
      field: speax_product_page_touch
      value: "Yes"
    }
  }

  measure: count_of_checkout_pages_touched {
    group_label: "Page Type"
    type: count
    filters: {
      field: checkout_page_touch
      value: "Yes"
    }
  }

  dimension: _ {
    type: string
    sql: ${TABLE}._ ;;
  }

  dimension: app_name {
    type: string
    sql: ${TABLE}.app_name ;;
  }

  dimension: app_version {
    type: string
    sql: ${TABLE}.app_version ;;
  }

  dimension: b {
    type: string
    sql: ${TABLE}.b ;;
  }

  dimension: browser {
    type: string
    sql: ${TABLE}.browser ;;
  }

  dimension: carrier {
    type: string
    sql: ${TABLE}.carrier ;;
  }

  dimension: cart_20count {
    type: string
    sql: ${TABLE}.cart_20count ;;
  }

  dimension: cart_count {
    type: string
    sql: ${TABLE}.cart_count ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension: device {
    type: string
    sql: ${TABLE}.device ;;
  }

  dimension: device_type {
    type: string
    sql: ${TABLE}.device_type ;;
  }

  dimension: domain {
    type: string
    sql: ${TABLE}.domain ;;
  }

  dimension: e {
    type: string
    sql: ${TABLE}.e ;;
  }

  dimension: event_id {
    type: number
    sql: ${TABLE}.event_id ;;
  }

  dimension: g {
    type: string
    sql: ${TABLE}.g ;;
  }

  dimension: gdpr_20popup_20state {
    type: string
    sql: ${TABLE}.gdpr_20popup_20state ;;
  }

  dimension: gdpr_popup_state {
    type: string
    sql: ${TABLE}.gdpr_popup_state ;;
  }

  dimension: h {
    type: string
    sql: ${TABLE}.h ;;
  }

  dimension: hash {
    type: string
    sql: ${TABLE}.hash ;;
  }

  dimension: ip {
    type: string
    sql: ${TABLE}.ip ;;
  }

  dimension: landing_page {
    type: string
    sql: ${TABLE}.landing_page ;;
  }

  dimension: library {
    type: string
    sql: ${TABLE}.library ;;
  }

  dimension: n {
    type: string
    sql: ${TABLE}.n ;;
  }

  dimension: navigation_20type {
    type: string
    sql: ${TABLE}.navigation_20type ;;
  }

  dimension: navigation_type {
    type: string
    sql: ${TABLE}.navigation_type ;;
  }

  dimension: o {
    type: string
    sql: ${TABLE}.o ;;
  }

  dimension: platform {
    type: string
    sql: ${TABLE}.platform ;;
  }

  dimension: query {
    type: string
    sql: ${TABLE}.query ;;
  }

  dimension: referrer {
    type: string
    sql: ${TABLE}.referrer ;;
  }

  dimension: region {
    type: string
    sql: ${TABLE}.region ;;
  }

  dimension: screen_a11y_id {
    type: string
    sql: ${TABLE}.screen_a11y_id ;;
  }

  dimension: screen_a11y_label {
    type: string
    sql: ${TABLE}.screen_a11y_label ;;
  }

  dimension: search_keyword {
    type: string
    sql: ${TABLE}.search_keyword ;;
  }

  dimension: session_id {
    type: number
    sql: ${TABLE}.session_id ;;
  }

  dimension_group: session {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.session_time ;;
  }

  dimension: t {
    type: string
    sql: ${TABLE}.t ;;
  }

  dimension_group: time {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.time ;;
  }

  dimension: title {
    type: string
    sql: ${TABLE}.title ;;
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
  }

  dimension: utm_campaign {
    type: string
    sql: ${TABLE}.utm_campaign ;;
  }

  dimension: utm_content {
    type: string
    sql: ${TABLE}.utm_content ;;
  }

  dimension: utm_medium {
    type: string
    sql: ${TABLE}.utm_medium ;;
  }

  dimension: utm_source {
    type: string
    sql: ${TABLE}.utm_source ;;
  }

  dimension: utm_term {
    type: string
    sql: ${TABLE}.utm_term ;;
  }

  dimension: v {
    type: string
    sql: ${TABLE}.v ;;
  }

  dimension: view_controller {
    type: string
    sql: ${TABLE}.view_controller ;;
  }

  dimension: w {
    type: string
    sql: ${TABLE}.w ;;
  }

  measure: count {
    type: count
    drill_fields: [user_id,session_id,event_id,path,session_date]
  }
}
