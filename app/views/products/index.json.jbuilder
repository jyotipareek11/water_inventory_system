json.array!(@products) do |product|
  json.extract! product, :name, :added_by, :modified_by
  json.url product_url(product, format: :json)
end
