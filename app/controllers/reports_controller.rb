class ReportsController < ApplicationController

	def index
	end	

	def monthly_invoicing
	end

	def invoice_report
		start_date = params[:invoice_start_date].to_time.beginning_of_day
		end_date = params[:invoice_end_date].to_time.beginning_of_day
		@sales = current_user.delivered_sales.present? ? current_user.delivered_sales.where(:created_at => start_date..end_date).to_a  : []
	end		

	 	
end