json.array!(@orders) do |order|
  json.extract! order, :sales_id, :added_by
  json.url order_url(order, format: :json)
end
