class PaperstocksController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :index, :destroy]
  before_action :set_paperstock, only: [:show, :edit, :update, :destroy]

  # GET /paperstocks
  # GET /paperstocks.json
  def index
    @paperstocks = Paperstock.all
  end

  # GET /paperstocks/1
  # GET /paperstocks/1.json
  def show
  end

  # GET /paperstocks/new
  def new
    @paperstock = Paperstock.new
  end

  # GET /paperstocks/1/edit
  def edit
  end

  # POST /paperstocks
  # POST /paperstocks.json
  def create
    @paperstock = Paperstock.new(paperstock_params)

    respond_to do |format|
      if @paperstock.save
        format.html { redirect_to @paperstock, notice: 'Paperstock was successfully created.' }
        format.json { render :show, status: :created, location: @paperstock }
      else
        format.html { render :new }
        format.json { render json: @paperstock.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /paperstocks/1
  # PATCH/PUT /paperstocks/1.json
  def update
    respond_to do |format|
      if @paperstock.update(paperstock_params)
        format.html { redirect_to @paperstock, notice: 'Paperstock was successfully updated.' }
        format.json { render :show, status: :ok, location: @paperstock }
      else
        format.html { render :edit }
        format.json { render json: @paperstock.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /paperstocks/1
  # DELETE /paperstocks/1.json
  def destroy
    @paperstock.paperstock_items.each do |paperstock_item|
      paperstock_item.destroy
    end
    @paperstock.destroy
    respond_to do |format|
      format.html { redirect_to paperstocks_url, notice: 'Paperstock was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_paperstock
      @paperstock = Paperstock.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def paperstock_params
      params.require(:paperstock).permit(
        :name,
        :color,
        paperstock_items_attributes: [:id, :_destroy, :name, :thirtytwofortyfive, :fiftytwoseventytwo, :toorder]
      )
    end

    def logged_in_user
      unless logged_in?
        flash[:danger] = 'Connectez-vous SVP'
        redirect_to login_url
      end
    end
end
