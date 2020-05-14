view: pageviews {
  sql_table_name: heap_thinx.pageviews ;;

  dimension: pk {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${event_id} || '|' || ${session_id} || '|' || ${user_id} ;;
  }

  dimension: path {
    type: string
    sql: lower(${TABLE}.path) ;;
    link: {
      label: "Link to Path"
      url: "http://www.shethinx.com{{value}}"
    }
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

  dimension: any_product_page_touch {
    group_label: "Page Type"
    type: yesno
    sql: ${thinx_product_page_touch} OR ${speax_product_page_touch} OR ${btwn_product_page_touch} ;;
  }

  dimension: checkout_page_touch {
    group_label: "Page Type"
    type: yesno
    sql: ${path} like '%checkouts%' or ${path} like '%checkouts%';;
  }

  dimension: session_include_gclid {
    hidden: yes
    group_label: "Session Information"
    type: yesno
    sql: ${query} like '%gclid%';;
  }

  measure: count_of_gclid_touched {
    group_label: "Session Information"
    type: count
    filters: {
      field: session_include_gclid
      value: "Yes"
    }
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

  measure: count_of_any_product_pages_touched {
    group_label: "Page Type"
    type: count
    filters: {
      field: any_product_page_touch
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
    hidden: yes
    type: string
    sql: ${TABLE}._ ;;
  }

  dimension: app_name {
    hidden: yes
    type: string
    sql: ${TABLE}.app_name ;;
  }

  dimension: app_version {
    hidden: yes
    type: string
    sql: ${TABLE}.app_version ;;
  }

  dimension: b {
    hidden: yes
    type: string
    sql: ${TABLE}.b ;;
  }

  dimension: browser {
    hidden: yes
    type: string
    sql: ${TABLE}.browser ;;
  }

  dimension: carrier {
    hidden: yes
    type: string
    sql: ${TABLE}.carrier ;;
  }

  dimension: cart_20count {
    hidden: yes
    type: string
    sql: ${TABLE}.cart_20count ;;
  }

  dimension: cart_count {
    hidden: yes
    type: string
    sql: ${TABLE}.cart_count ;;
  }

  dimension: city {
    hidden: yes
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: country {
    hidden: yes
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension: device {
    hidden: yes
    type: string
    sql: ${TABLE}.device ;;
  }

  dimension: device_type {
    hidden: yes
    type: string
    sql: ${TABLE}.device_type ;;
  }

  dimension: domain {
    hidden: yes
    type: string
    sql: ${TABLE}.domain ;;
  }

  dimension: e {
    hidden: yes
    type: string
    sql: ${TABLE}.e ;;
  }

  dimension: event_id {
    hidden: yes
    type: number
    sql: ${TABLE}.event_id ;;
  }

  dimension: g {
    hidden: yes
    type: string
    sql: ${TABLE}.g ;;
  }

  dimension: gdpr_20popup_20state {
    hidden: yes
    type: string
    sql: ${TABLE}.gdpr_20popup_20state ;;
  }

  dimension: gdpr_popup_state {
    hidden: yes
    type: string
    sql: ${TABLE}.gdpr_popup_state ;;
  }

  dimension: h {
    hidden: yes
    type: string
    sql: ${TABLE}.h ;;
  }

  dimension: hash {
    hidden: yes
    type: string
    sql: ${TABLE}.hash ;;
  }

  dimension: ip {
    hidden: yes
    type: string
    sql: ${TABLE}.ip ;;
  }

  dimension: landing_page {
    type: string
    sql: ${TABLE}.landing_page ;;
  }

  dimension: library {
    hidden: yes
    type: string
    sql: ${TABLE}.library ;;
  }

  dimension: n {
    hidden: yes
    type: string
    sql: ${TABLE}.n ;;
  }

  dimension: navigation_20type {
    hidden: yes
    type: string
    sql: ${TABLE}.navigation_20type ;;
  }

  dimension: navigation_type {
    hidden: yes
    type: string
    sql: ${TABLE}.navigation_type ;;
  }

  dimension: o {
    hidden: yes
    type: string
    sql: ${TABLE}.o ;;
  }

  dimension: platform {
    hidden: yes
    type: string
    sql: ${TABLE}.platform ;;
  }

  dimension: query {
    hidden: yes
    type: string
    sql: lower(${TABLE}.query) ;;
  }

  dimension: referrer {
    type: string
    sql: ${TABLE}.referrer ;;
  }

  dimension: region {
    hidden: yes
    type: string
    sql: ${TABLE}.region ;;
  }

  dimension: screen_a11y_id {
    hidden: yes
    type: string
    sql: ${TABLE}.screen_a11y_id ;;
  }

  dimension: screen_a11y_label {
    hidden: yes
    type: string
    sql: ${TABLE}.screen_a11y_label ;;
  }

  dimension: search_keyword {
    hidden: yes
    type: string
    sql: ${TABLE}.search_keyword ;;
  }

  dimension: session_id {
    hidden: yes
    type: number
    sql: ${TABLE}.session_id ;;
  }

  dimension_group: session {
    hidden: yes
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
    hidden: yes
    type: string
    sql: ${TABLE}.t ;;
  }

  dimension_group: pageview {
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
    hidden: yes
    type: string
    sql: ${TABLE}.title ;;
  }

  dimension: user_id {
    hidden: yes
    type: number
    sql: ${TABLE}.user_id ;;
  }

  dimension: utm_campaign {
    group_label: "UTM Information"
    type: string
    sql: ${TABLE}.utm_campaign ;;
  }

  dimension: utm_content {
    group_label: "UTM Information"
    type: string
    sql: ${TABLE}.utm_content ;;
  }

  dimension: utm_medium {
    group_label: "UTM Information"
    type: string
    sql: ${TABLE}.utm_medium ;;
  }

  dimension: utm_source {
    group_label: "UTM Information"
    type: string
    sql: ${TABLE}.utm_source ;;
  }

  dimension: utm_term {
    group_label: "UTM Information"
    type: string
    sql: ${TABLE}.utm_term ;;
  }

  dimension: v {
    hidden: yes
    type: string
    sql: ${TABLE}.v ;;
  }

  dimension: view_controller {
    hidden: yes
    type: string
    sql: ${TABLE}.view_controller ;;
  }

  dimension: w {
    hidden: yes
    type: string
    sql: ${TABLE}.w ;;
  }

  measure: count_of_pageviews {
    type: count
  }
}
