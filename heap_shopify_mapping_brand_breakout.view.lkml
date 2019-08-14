view: heap_shopify_order_mapping {
  derived_table: {
    sql: SELECT order_number, listagg(distinct case when vendor = 'Thinx Underwear' then 'THINX' when vendor = 'MAS' then 'Speax'  else vendor end,',') as included_brands FROM thinx_shopify.orders
      LEFT JOIN orders__line_items ON
      orders__line_items._sdc_source_key_id=orders.id
      group by 1

       ;;
  }

  measure: count {
    type: count
#     drill_fields: [detail*]
  }

  dimension: order_number {
    type: number
    sql: ${TABLE}.order_number ;;
  }

  dimension: included_brands {
    type: string
    sql: ${TABLE}.included_brands ;;
  }

#   set: detail {
#     fields: [order_number, listagg]
#   }
}
