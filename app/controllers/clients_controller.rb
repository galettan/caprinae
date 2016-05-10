class ClientsController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :index, :destroy]

  def index
    @clients = Client.order(:name).paginate(page: params[:page])
    if params[:disabled].present?
      @clients = @clients.disabled(params[:disabled]).paginate(page: params[:page])
    else
      @clients = @clients.where('disable IS NULL')
    end
    @projects = @projects.passed(params[:archived]).paginate(page: params[:page]) if params[:archived].present?
    @clients = @clients.search_name(params[:name]).order(:name).paginate(page: params[:page]) if params[:name].present?  
    @clients = @clients.contact_email(params[:email]).order(:name).paginate(page: params[:page]) if params[:email].present?
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
  
  def action
    @client = Client.find(params[:id])
  end

  def deactivate
    @client = Client.find(params[:id])
    @client.contacts.each do |contact|
      contact.participant.each do |participant|
        @project = Project.find(participant.project_id)
        if @project.estimated_time?
          @project.hours = @project.estimated_time / 60
          @project.minutes = @project.estimated_time % 60
        end
        @project.archived = true
        if @project.save
          flash[:warning] = 'Projets archivés'
        else
          flash[:danger] = 'Projets non archivés'
        end
      end
    end
    @client.disable = true
    if @client.save
      flash[:warning] = 'Client désactivé' 
      redirect_to clients_url
    else
      falsh[:danger] ='Un problème est survenu lors de la désactivation du client'
    end
  end
  
  def activate
    @client = Client.find(params[:id])
    @client.disable = nil
    if @client.save
      flash[:success] = 'Client activé' 
      redirect_to clients_url
    else
      falsh[:danger] = 'Un problème est survenu lors de l\'activation du client'
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
    @client = Client.find(params[:id])
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
        :name, :street, :postal_code, :city,
        contacts_attributes: [:id, :_destroy, :first_name, :last_name, :email, :phone_nbr, :client_id]
      )
    end
    
end