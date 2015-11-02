class ClientsController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :index, :destroy]

  def index
    @clients = Client.paginate(page: params[:page])
  end

  def show
    @client = Client.find_detailed(params[:id])
  end

  def new
    @client = Client.new
  end

  def edit
    @client = Client.find_detailed(params[:id])
  end

  def create
    @client = Client.new(client_params)

    respond_to do |format|
      if @client.save
        flash[:success] = 'Client créé'
        format.html { redirect_to @client }
        format.json { render :show, status: :created, location: @client }
      else
        flash[:danger] = 'Client non créé'
        format.html { render :new }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end
  
  
  def update
    @client = Client.find(params[:id])
    
    if @client.update(client_params)
        flash[:success] = 'Client mis à jour avec succès'
        redirect_to @client
      else
        format.html { render :edit }
      end
  end

  def destroy
    @client.destroy
    respond_to do |format|
      format.html { redirect_to clients_url, notice: 'Client was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    
    def logged_in_user
      unless logged_in?
        flash[:danger] = 'Connectez-vous SVP'
        redirect_to login_url
      end
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def client_params
      params.require(:client).permit(
        :name, :street, :postal_code, :town,
        contacts_attributes: [:id, :_destroy, :first_name, :last_name, :email, :phone_nbr, :client_id]
      )
    end


end