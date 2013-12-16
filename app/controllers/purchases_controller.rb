class PurchasesController < ApplicationController
  before_action :set_purchase, only: [:show, :edit, :update, :destroy]
  before_action :set_vendor
  before_action :set_association, only: [:show]
  # GET /purchases
  # GET /purchases.json
  def index
    @purchases = @vendor.purchases
  end

  # GET /purchases/1
  # GET /purchases/1.json
  def show
     @created_user = User.find(@purchase.added_by)
  end

  # GET /purchases/new
  def new
    @purchase = Purchase.new
    @products = Product.all
  end

  # GET /purchases/1/edit
  def edit
  end

  # POST /purchases
  # POST /purchases.json
  def create
    @purchase = Purchase.new(purchase_params)
    @purchase.vendor = @vendor
    @purchase.added_by = current_user.id
    respond_to do |format|
      if @purchase.save
        format.html { redirect_to vendor_purchase_path(@vendor,@purchase), notice: 'Purchase was successfully created.' }
        format.json { render action: 'show', status: :created, location: @purchase }
      else
        format.html { render action: 'new' }
        format.json { render json: @purchase.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /purchases/1
  # PATCH/PUT /purchases/1.json
  def update
    respond_to do |format|
      if @purchase.update(purchase_params)
        format.html { redirect_to @purchase, notice: 'Purchase was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @purchase.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /purchases/1
  # DELETE /purchases/1.json
  def destroy
    @purchase.destroy
    respond_to do |format|
      format.html { redirect_to vendor_purchases_path(@vendor) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_purchase
      @purchase = Purchase.find(params[:id])
    end

    def set_vendor
      @vendor = Vendor.find(params[:vendor_id])
    end

    def set_association
      @product = @purchase.product
      @vendor = @purchase.vendor
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def purchase_params
      params.require(:purchase).permit(:no_of_unit, :unit_price, :total_price, :price_after_discount,:product_id, :discount, :added_by, :modified_by)
    end
end
