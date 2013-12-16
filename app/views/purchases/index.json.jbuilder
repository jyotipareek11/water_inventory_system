json.array!(@purchases) do |purchase|
  json.extract! purchase, :no_of_unit, :unit_price, :total_price, :discount, :added_by, :modified_by
  json.url purchase_url(purchase, format: :json)
end
