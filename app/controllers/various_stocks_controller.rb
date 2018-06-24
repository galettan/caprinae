class VariousStocksController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :index, :destroy]
  before_action :set_various_stock, only: [:show, :edit, :update, :destroy]

  # GET /various_stocks
  # GET /various_stocks.json
  def index
    @various_stocks = VariousStock.all
  end

  # GET /various_stocks/1
  # GET /various_stocks/1.json
  def show
  end

  # GET /various_stocks/new
  def new
    @various_stock = VariousStock.new
  end

  # GET /various_stocks/1/edit
  def edit
  end

  # POST /various_stocks
  # POST /various_stocks.json
  def create
    @various_stock = VariousStock.new(various_stock_params)

    respond_to do |format|
      if @various_stock.save
        format.html { redirect_to @various_stock, notice: 'Various stock was successfully created.' }
        format.json { render :show, status: :created, location: @various_stock }
      else
        format.html { render :new }
        format.json { render json: @various_stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /various_stocks/1
  # PATCH/PUT /various_stocks/1.json
  def update
    respond_to do |format|
      if @various_stock.update(various_stock_params)
        format.html { redirect_to @various_stock, notice: 'Various stock was successfully updated.' }
        format.json { render :show, status: :ok, location: @various_stock }
      else
        format.html { render :edit }
        format.json { render json: @various_stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /various_stocks/1
  # DELETE /various_stocks/1.json
  def destroy
    @various_stock.destroy
    respond_to do |format|
      format.html { redirect_to various_stocks_url, notice: 'Various stock was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_various_stock
      @various_stock = VariousStock.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def various_stock_params
      params.require(:various_stock).permit(
        :name, :color,
        variousStockItems_attributes: [:id, :_destroy, :name, :quantity]
      )
    end
    
    def logged_in_user
      unless logged_in?
        flash[:danger] = 'Connectez-vous SVP'
        redirect_to login_url
      end
    end
end
