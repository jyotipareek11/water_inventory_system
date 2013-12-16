json.array!(@vendors) do |vendor|
  json.extract! vendor, :name, :address1, :address2, :city, :state, :country, :user_id, :modified_by
  json.url vendor_url(vendor, format: :json)
end
