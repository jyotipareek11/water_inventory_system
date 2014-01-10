class AddColumnIsActiveToAll < ActiveRecord::Migration
  def change
  	add_column :users, :is_active, :boolean, default: true
  	add_column :locations, :is_active, :boolean, default: true
  	add_column :clients, :is_active, :boolean, default: true
  	add_column :vendors, :is_active, :boolean, default: true
  	add_column :products, :is_active, :boolean, default: true
  	add_column :sales, :is_active, :boolean, default: true
  	add_column :purchases, :is_active, :boolean, default: true
  end
end
