view: heap_orders_sales_summary_ndt {

  sql_table_name: looker_scratch.uc_thinx_heap_orders_sales_summary_ndt ;;
  drill_fields: [shopify_details*]

  dimension: order_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    link: {
      label: "Link to Shopify"
      url: "https://she-thinx.myshopify.com/admin/orders/{{value}}"
      icon_url: "https://cdn.shopify.com/shopify-marketing_assets/static/shopify-favicon.png"
      #link will not work for OLD Speax orders, will need the old Speax URL path
    }
  }
  dimension: session_id {
    hidden: yes
    type: number
    sql: ${TABLE}.session_id ;;
  }
  dimension: order_sequence {
    label: "Sequenced Order Count Sequenced Order Count"
    description: "Is this the customer's first order? Second order? Etc."
    type: number
    sql: ${TABLE}.order_sequence ;;
  }
  dimension: gross_sales {
    group_label: "Gross Sales"
    value_format_name: usd
    type: number
    sql: ${TABLE}.gross_sales ;;
  }
  dimension: gross_thinx_sales {
    group_label: "Gross Sales"
    value_format_name: usd
    type: number
    sql: ${TABLE}.gross_thinx_sales ;;
  }
  dimension: gross_speax_sales {
    group_label: "Gross Sales"
    value_format_name: usd
    type: number
    sql: ${TABLE}.gross_speax_sales ;;
  }
  dimension: gross_btwn_sales {
    group_label: "Gross Sales"
    label: "Gross BTWN Sales"
    value_format_name: usd
    type: number
    sql: ${TABLE}.gross_btwn_sales ;;
  }

  dimension: count_of_items {
    hidden: yes
    type: number
    sql: ${TABLE}.count ;;
  }
  dimension: count_of_thinx_items {
    hidden: yes
    type: number
    sql: ${TABLE}.count_of_thinx_items ;;
  }
  dimension: count_of_speax_items {
    hidden: yes
    type: number
    sql: ${TABLE}.count_of_speax_items ;;
  }
  dimension: count_of_btwn_items {
    hidden: yes
    type: number
    sql: ${TABLE}.count_of_btwn_items ;;
  }
  dimension: total_quantity_sold {
    hidden: yes
    type: number
    sql: ${TABLE}.total_quantity_sold ;;
  }
  dimension: total_thinx_quantity_sold {
    hidden: yes
    type: number
    sql: ${TABLE}.total_thinx_quantity_sold ;;
  }
  dimension: total_speax_quantity_sold {
    hidden: yes
    type: number
    sql: ${TABLE}.total_speax_quantity_sold ;;
  }
  dimension: total_btwn_quantity_sold {
    hidden: yes
    type: number
    sql: ${TABLE}.total_btwn_quantity_sold ;;
  }
  dimension: count_of_orders {
    hidden: yes
    type: number
    sql: ${TABLE}.count_of_orders ;;
  }
  dimension: thinx_products_purchased {
    group_label: "Products Purchased"
    type: yesno
    sql: ${count_of_thinx_items} > 0 ;;
  }

  dimension: speax_products_purchased {
    group_label: "Products Purchased"
    type: yesno
    sql: ${count_of_speax_items} > 0 ;;
  }

  dimension: btwn_products_purchased {
    group_label: "Products Purchased"
    label: "BTWN Products Purchased"
    type: yesno
    sql: ${count_of_btwn_items} > 0 ;;
  }

  dimension: net_sales {
    group_label: "Net Sales"
    value_format_name: usd
    type: number
    sql: ${TABLE}.net_sales ;;
  }
  dimension: net_thinx_sales {
    group_label: "Net Sales"
    value_format_name: usd
    type: number
    sql: ${TABLE}.net_thinx_sales ;;
  }
  dimension: net_speax_sales {
    group_label: "Net Sales"
    value_format_name: usd
    type: number
    sql: ${TABLE}.net_speax_sales ;;
  }
  dimension: net_btwn_sales {
    group_label: "Net Sales"
    label: "Net BTWN Sales"
    value_format_name: usd
    type: number
    sql: ${TABLE}.net_btwn_sales ;;
  }

  measure: total_gross_sales {
    group_label: "Gross Sales"
    value_format_name: usd
    type: sum
    sql: ${gross_sales} ;;
  }
  measure: total_gross_thinx_sales {
    group_label: "Gross Sales"
    value_format_name: usd
    type: sum
    sql: ${gross_thinx_sales};;
  }
  measure: total_gross_speax_sales {
    group_label: "Gross Sales"
    value_format_name: usd
    type: sum
    sql: ${gross_speax_sales} ;;
  }
  measure: total_gross_btwn_sales {
    group_label: "Gross Sales"
    label: "Total Gross BTWN Sales"
    value_format_name: usd
    type: sum
    sql: ${gross_btwn_sales} ;;
  }
  measure: total_products_purchased {
    group_label: "Products Purchased"
    type: sum
    sql: ${count_of_items} ;;
  }
  measure: total_thinx_products_purchased {
    group_label: "Products Purchased"
    type: sum
    sql: ${count_of_thinx_items} ;;
  }
  measure: total_speax_products_purchased {
    group_label: "Products Purchased"
    type: sum
    sql: ${count_of_speax_items} ;;
  }
  measure: total_btwn_products_purchased {
    group_label: "Products Purchased"
    label: "Total BTWN Products Purchased"
    type: sum
    sql: ${count_of_btwn_items} ;;
  }
  measure: total_net_sales {
    group_label: "Net Sales"
    value_format_name: usd
    type: sum
    sql: ${net_sales} ;;
  }
  measure: total_net_thinx_sales {
    group_label: "Net Sales"
    value_format_name: usd
    type: sum
    sql: ${net_thinx_sales} ;;
  }
  measure: total_net_speax_sales {
    group_label: "Net Sales"
    value_format_name: usd
    type: sum
    sql: ${net_speax_sales} ;;
  }
  measure: total_net_btwn_sales {
    group_label: "Net Sales"
    label: "Total Net BTWN Sales"
    value_format_name: usd
    type: sum
    sql: ${net_btwn_sales} ;;
  }
  measure: total_units_sold {
    group_label: "Units Sold"
    type: sum
    sql: ${total_quantity_sold} ;;
  }
  measure: total_thinx_units_sold {
    group_label: "Units Sold"
    type: sum
    sql: ${total_thinx_quantity_sold} ;;
  }
  measure: total_speax_units_sold {
    group_label: "Units Sold"
    type: sum
    sql: ${total_speax_quantity_sold} ;;
  }
  measure: total_btwn_units_sold {
    group_label: "Units Sold"
    label: "Total BTWN Units Sold"
    type: sum
    sql: ${total_btwn_quantity_sold} ;;
  }
  measure: total_count_of_orders {
    type: sum
    sql: ${count_of_orders} ;;
  }

  measure: session_conversion {
    group_label: "Web Metrics"
    description: "Orders / All Sessions"
    type: number
    sql: 1.0 * ${total_count_of_orders} / nullif(${sessions.count},0) ;;
    value_format_name: percent_1
  }

  measure: checkout_conversion {
    group_label: "Web Metrics"
    description: "Orders / All Sessions with Checkout Touched"
    type: number
    sql: 1.0 * ${total_count_of_orders} / nullif(${pageviews_summary.sessions_checkout_pages_touched},0) ;;
    value_format_name: percent_1
  }

  measure: cart_conversion {
    group_label: "Web Metrics"
    description: "Orders / All Sessions with Cart Touched"
    type: number
    sql: 1.0 * ${total_count_of_orders} / nullif(${pageviews_summary.sessions_cart_pages_touched},0) ;;
    value_format_name: percent_1
  }

  measure: pdp_conversion {
    group_label: "Web Metrics"
    label: "PDP Conversion"
    description: "Orders / All Sessions with PDP Touched"
    type: number
    sql: 1.0 * ${total_count_of_orders} / nullif(${pageviews_summary.sessions_any_product_pages_touched},0) ;;
    value_format_name: percent_1
  }

  measure: revenue_per_session {
    group_label: "Web Metrics"
    description: "Gross Sales / All Sessions"
    type: number
    sql: 1.0 * ${total_gross_sales} / nullif(${sessions.count},0) ;;
    value_format_name: usd_0
  }

  set: shopify_details {
    fields: [order_id,order_sequence,gross_sales,gross_thinx_sales,gross_speax_sales,gross_btwn_sales,net_sales,net_thinx_sales,net_speax_sales,net_btwn_sales]
  }
}
