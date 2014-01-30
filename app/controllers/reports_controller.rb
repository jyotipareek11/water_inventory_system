class ReportsController < ApplicationController

	def index
	end	

	def monthly_invoicing
	end

	def invoice_report
		valid = true
		@start_date = params[:invoice_start_date]
		@end_date = params[:invoice_end_date]
		from_time = @start_date.to_time.beginning_of_day
		end_time = @end_date.to_time.beginning_of_day

		if(end_time < from_time)
			valid = false
		else
			valid = true
			@sales = current_user.delivered_sales.present? ? current_user.delivered_sales.where(:created_at => from_time..end_time).to_a  : []	
		end
		respond_to do |format|
			if valid
				format.html
				format.xls
			else
				format.html { redirect_to monthly_invoicing_reports_url, notice: 'Start date must me less then End date.' }
				format.xls
			end	
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