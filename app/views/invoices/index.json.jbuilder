json.array!(@invoices) do |invoice|
  json.extract! invoice, :no_of_unit, :unit_price, :total_price, :discount, :price_after_discount
  json.url invoice_url(invoice, format: :json)
end
