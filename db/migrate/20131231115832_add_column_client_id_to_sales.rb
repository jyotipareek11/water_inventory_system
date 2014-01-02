class AddColumnClientIdToSales < ActiveRecord::Migration
  def change
  	add_column :sales, :client_id, :integer
  end
end
