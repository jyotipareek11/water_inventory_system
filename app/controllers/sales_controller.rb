class SalesController < ApplicationController
  before_action :set_sale, only: [:show, :edit, :update, :destroy, :update_state]
  before_action :set_association, only: [:show]

  # GET /sales
  # GET /sales.json
  def index
    @sales = Sale.where('user_id = ?',current_user.id).to_a
  end

  # GET /sales/1
  # GET /sales/1.json
  def show
  end

  # GET /sales/new
  def new
    @sale = Sale.new
    invoice = @sale.build_invoice
    invoice_product = invoice.invoice_products.build
    @display_error = false
    # sale_product = @sale.sale_products.build
    # order.order_products.build 
  end

  # GET /sales/1/edit
  def edit
  end

  # POST /sales
  # POST /sales.json
  def create
    @sale = Sale.new(sale_params)
    @sale.update_associations(current_user)
    @sale.state = "order_initiated"
    respond_to do |format|
      if @sale.save
        format.html { redirect_to @sale, notice: 'Sale was successfully created.' }
        format.json { render action: 'show', status: :created, location: @sale }
      else
        @display_error = true
        format.html { render action: 'new' }
        format.json { render json: @sale.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sales/1
  # PATCH/PUT /sales/1.json
  def update
    respond_to do |format|
      if @sale.update(sale_params)
        format.html { redirect_to @sale, notice: 'Sale was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @sale.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sales/1
  # DELETE /sales/1.json
  def destroy
    @sale.destroy
    respond_to do |format|
      format.html { redirect_to sales_url }
      format.json { head :no_content }
    end
  end

  def update_state
    respond_to do |format|
      if @sale.update_state_and_inventory
        format.html { redirect_to sales_path, notice: 'Sale was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { redirect_to sales_path, notice: 'Sorry some error has occure!!! Not able to update Sale.' }
        format.json { render json: @sale.errors, status: :unprocessable_entity, notice: 'Sorry some error has occure!!! Not able to update Sale.' }
      end
    end
  end  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sale
      @sale = Sale.find(params[:id])
    end

    def set_association
      @location = @sale.location if current_user.is_admin?
      @client = @sale.client if current_user.is_distributor?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sale_params
      params.require(:sale).permit(:location_id, :distributor_id, :total_quantity, :total_amout, :discount, :total_after_discount,:client_id,
          :invoice_attributes => [:no_of_unit,:total_price,:discount,:price_after_discount,
            :invoice_products_attributes => [:product_id,:no_of_unit,:unit_price,:total_price,:discount,:price_after_discount, :user_id,:state, :from,:_destroy]
          ]
        )
    end
end
