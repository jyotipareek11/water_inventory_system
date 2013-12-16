json.array!(@locations) do |location|
  json.extract! location, :name, :address1, :address2, :city, :state, :country, :added_by, :added_date, :modified_by, :modified_date
  json.url location_url(location, format: :json)
end
