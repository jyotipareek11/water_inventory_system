json.array!(@sales) do |sale|
  json.extract! sale, :location_id, :distributor_id, :total_quantity, :total_amout, :discount, :total_after_discount
  json.url sale_url(sale, format: :json)
end
