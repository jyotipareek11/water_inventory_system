json.array!(@purchase_orders) do |purchase_order|
  json.extract! purchase_order, :vendor_id, :no_of_unit, :unit_price, :total_price, :discount, :price_after_discount, :added_by, :modified_by
  json.url purchase_order_url(purchase_order, format: :json)
end
