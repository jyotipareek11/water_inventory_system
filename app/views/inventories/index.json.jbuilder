json.array!(@inventories) do |inventory|
  json.extract! inventory, :quantity
  json.url inventory_url(inventory, format: :json)
end
