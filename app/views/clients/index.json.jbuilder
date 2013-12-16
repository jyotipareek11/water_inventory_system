json.array!(@clients) do |client|
  json.extract! client, :name, :distributer_id, :address1, :address2, :city, :state, :country, :pin, :email_id, :land_line_number, :mobile_no, :added_by, :modified_by
  json.url client_url(client, format: :json)
end
