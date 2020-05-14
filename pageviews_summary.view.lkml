view: pageviews_summary {
  derived_table: {
    publish_as_db_view: yes
    datagroup_trigger: heap_refresh
    distribution: "session_id"
    sortkeys: ["session_id"]
    explore_source: pageviews {
      column: session_id {}
      column: count_of_account_pages_touched {}
      column: count_of_blog_pages_touched {}
      column: count_of_btwn_pages_touched {}
      column: count_of_cart_pages_touched {}
      column: count_of_leader_pages_touched {}
      column: count_of_order_pages_touched {}
      column: count_of_speax_pages_touched {}
      column: count_of_thinx_pages_touched {}
      column: count_of_thinx_product_pages_touched {}
      column: count_of_btwn_product_pages_touched {}
      column: count_of_checkout_pages_touched {}
      column: count_of_speax_product_pages_touched {}
      column: count_of_any_product_pages_touched {}
      column: count_of_gclid_touched {}
    }
  }
  dimension: session_id {
    primary_key: yes
    hidden: yes
    type: number
  }
  dimension: count_of_account_pages_touched {
    hidden: yes
    type: number
  }
  dimension: account_page_touched {
    group_label: "Page Touched"
    type: yesno
    sql: ${count_of_account_pages_touched} > 0 ;;
  }
  dimension: count_of_blog_pages_touched {
    hidden: yes
    type: number
  }
  dimension: blog_page_touched {
    group_label: "Page Touched"
    type: yesno
    sql: ${count_of_blog_pages_touched} > 0 ;;
  }
  dimension: count_of_btwn_pages_touched {
    hidden: yes
    type: number
  }
  dimension:btwn_page_touched {
    group_label: "Page Touched"
    type: yesno
    sql: ${count_of_btwn_pages_touched} > 0 ;;
  }
  dimension: count_of_cart_pages_touched {
    hidden: yes
    type: number
  }
  dimension:cart_page_touched {
    group_label: "Page Touched"
    type: yesno
    sql: ${count_of_cart_pages_touched} > 0 ;;
  }
  dimension: count_of_leader_pages_touched {
    hidden: yes
    type: number
  }
  dimension:leader_page_touched {
    group_label: "Page Touched"
    type: yesno
    sql: ${count_of_leader_pages_touched} > 0 ;;
  }
  dimension: count_of_order_pages_touched {
    hidden: yes
    type: number
  }
  dimension:order_page_touched {
    group_label: "Page Touched"
    type: yesno
    sql: ${count_of_order_pages_touched} > 0 ;;
  }
  dimension: count_of_speax_pages_touched {
    hidden: yes
    type: number
  }
  dimension:speax_page_touched {
    group_label: "Page Touched"
    type: yesno
    sql: ${count_of_speax_pages_touched} > 0 ;;
  }
  dimension: count_of_thinx_pages_touched {
    hidden: yes
    type: number
  }
  dimension:thinx_page_touched {
    group_label: "Page Touched"
    type: yesno
    sql: ${count_of_thinx_pages_touched} > 0 ;;
  }
  dimension: count_of_thinx_product_pages_touched {
    hidden: yes
    type: number
  }
  dimension:thinx_product_page_touched {
    group_label: "Page Touched"
    type: yesno
    sql: ${count_of_thinx_product_pages_touched} > 0 ;;
  }
  dimension: count_of_btwn_product_pages_touched {
    hidden: yes
    type: number
  }
  dimension: btwn_product_page_touched {
    group_label: "Page Touched"
    type: yesno
    sql: ${count_of_btwn_product_pages_touched} > 0 ;;
  }
  dimension: count_of_checkout_pages_touched {
    hidden: yes
    type: number
  }
  dimension: checkout_page_touched {
    group_label: "Page Touched"
    type: yesno
    sql: ${count_of_checkout_pages_touched} > 0 ;;
  }
  dimension: count_of_speax_product_pages_touched {
    hidden: yes
    type: number
  }
  dimension: speax_product_page_touched {
    group_label: "Page Touched"
    type: yesno
    sql: ${count_of_speax_product_pages_touched} > 0 ;;
  }
  dimension: count_of_any_product_pages_touched {
    hidden: yes
    type: number
  }
  dimension: any_product_page_touched {
    group_label: "Page Touched"
    type: yesno
    sql: ${count_of_any_product_pages_touched} > 0 ;;
  }
  dimension: count_of_gclid_touched {
    hidden: yes
    type: yesno
    sql: ${TABLE}.count_of_gclid_touched ;;
  }
  dimension: session_include_gclid {
    type: yesno
    sql: ${count_of_gclid_touched} > 0 ;;
  }

  measure: total_account_pages_touched {
    group_label: "Total Pages"
    type: sum
    sql: ${count_of_account_pages_touched} ;;
  }

  measure: sessions_account_pages_touched {
    group_label: "Session Count"
    type: count
    filters: {
      field: account_page_touched
      value: "Yes"
    }
  }

  measure: total_blog_pages_touched {
    group_label: "Total Pages"
    type: sum
    sql: ${count_of_blog_pages_touched} ;;
  }

  measure: sessions_blog_pages_touched {
    group_label: "Session Count"
    type: count
    filters: {
      field: blog_page_touched
      value: "Yes"
    }
  }

  measure: total_btwn_pages_touched {
    group_label: "Total Pages"
    type: sum
    sql: ${count_of_btwn_pages_touched} ;;
  }

  measure: sessions_btwn_pages_touched {
    group_label: "Session Count"
    type: count
    filters: {
      field: btwn_page_touched
      value: "Yes"
    }
  }

  measure: total_cart_pages_touched {
    group_label: "Total Pages"
    type: sum
    sql: ${count_of_cart_pages_touched} ;;
  }

  measure: sessions_cart_pages_touched {
    group_label: "Session Count"
    type: count
    filters: {
      field: cart_page_touched
      value: "Yes"
    }
  }

  measure: total_leader_pages_touched {
    group_label: "Total Pages"
    type: sum
    sql: ${count_of_leader_pages_touched};;
  }

  measure: sessions_leader_pages_touched {
    group_label: "Session Count"
    type: count
    filters: {
      field: leader_page_touched
      value: "Yes"
    }
  }

  measure: total_order_pages_touched {
    group_label: "Total Pages"
    type: sum
    sql: ${count_of_order_pages_touched}  ;;
  }

  measure: sessions_order_pages_touched {
    group_label: "Session Count"
    type: count
    filters: {
      field: order_page_touched
      value: "Yes"
    }
  }

  measure: total_speax_pages_touched {
    group_label: "Total Pages"
    type: sum
    sql: ${count_of_speax_pages_touched} ;;
  }

  measure: sessions_speax_pages_touched {
    group_label: "Session Count"
    type: count
    filters: {
      field: speax_page_touched
      value: "Yes"
    }
  }

  measure: total_thinx_pages_touched {
    group_label: "Total Pages"
    type: sum
    sql: ${count_of_thinx_pages_touched} ;;
  }

  measure: sessions_thinx_pages_touched {
    group_label: "Session Count"
    type: count
    filters: {
      field: thinx_page_touched
      value: "Yes"
    }
  }

  measure: total_thinx_product_pages_touched {
    group_label: "Total Pages"
    type: sum
    sql: ${count_of_thinx_pages_touched} ;;
  }

  measure: sessions_thinx_product_pages_touched {
    group_label: "Session Count"
    type: count
    filters: {
      field: thinx_product_page_touched
      value: "Yes"
    }
  }

  measure: total_btwn_product_pages_touched {
    group_label: "Total Pages"
    type: sum
    sql: ${count_of_btwn_product_pages_touched} ;;
  }

  measure: sessions_btwn_product_pages_touched {
    group_label: "Session Count"
    type: count
    filters: {
      field: btwn_product_page_touched
      value: "Yes"
    }
  }

  measure: total_checkout_pages_touched {
    group_label: "Total Pages"
    type: sum
    sql: ${count_of_checkout_pages_touched} ;;
  }

  measure: sessions_checkout_pages_touched {
    group_label: "Session Count"
    type: count
    filters: {
      field: checkout_page_touched
      value: "Yes"
    }
  }

  measure: total_speax_product_pages_touched {
    group_label: "Total Pages"
    type: sum
    sql: ${count_of_speax_product_pages_touched} ;;
  }

  measure: sessions_speax_product_pages_touched {
    group_label: "Session Count"
    type: count
    filters: {
      field: speax_product_page_touched
      value: "Yes"
    }
  }

  measure: sessions_any_product_pages_touched {
    group_label: "Session Count"
    type: count
    filters: {
      field: any_product_page_touched
      value: "Yes"
    }
  }

}
