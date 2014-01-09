class ReportsController < ApplicationController

	def index
	end	

	def monthly_invoicing
	end

	def invoice_report
		@start_date = params[:invoice_start_date]
		@end_date = params[:invoice_end_date]
		@sales = current_user.delivered_sales.present? ? current_user.delivered_sales.where(:created_at => @start_date.to_time.beginning_of_day..@end_date.to_time.beginning_of_day).to_a  : []
		respond_to do |format|
			format.html
			format.xls
		end	
	end	

	def monthly_inventory
	end

	def inventory_report
		@distributor = User.find(params[:distributor_id]) 
		@inventories = @distributor.inventories

		respond_to do |format|
			format.html
			format.xls
		end	
	end		


end