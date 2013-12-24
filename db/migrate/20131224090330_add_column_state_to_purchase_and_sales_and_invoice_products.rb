class AddColumnStateToPurchaseAndSalesAndInvoiceProducts < ActiveRecord::Migration
  def change
  	add_column :purchases, :state, :string
  	add_column :sales, :state, :string
  	add_column :invoice_products, :state, :string

  end
end
