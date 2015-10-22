class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:edit, :update, :index, :destroy]

  # GET /projects
  # GET /projects.json
  def index
    if current_user.manager?
      @projects = Project.by_owner(current_user.id).order(priority: :desc, number: :asc).paginate(page: params[:page])
    else 
      profile = current_user.profile == 'crea' ? 1 : 0
      @projects = Project.by_profile(current_user.id).order(priority: :desc, number: :asc).paginate(page: params[:page])
    end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @project = Project.find_detailed(params[:id])
    @spent_time = @project.tasks.sum(:duration)
  end

  # GET /projects/new
  def new
    @project = Project.new
    @client = Client.all
  end

  # GET /projects/1/edit
  def edit
    @client = Client.all
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)
    @client = Client.all

    @project.owner_id = current_user.id
    respond_to do |format|
      if @project.save
        flash[:success] = 'Projet créé'
        format.html { redirect_to @project }
        format.json { render :show, status: :created, location: @project }
      else
        p @project.errors
        flash[:danger] = 'Projet non créé'
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    @client = Client.all
    respond_to do |format|
      if @project.update(project_params)
        flash[:success] = 'Projet mis à jour avec succès'
        format.html { redirect_to @project}
        format.json { render :show, status: :ok, location: @project }
      else
        flash[:danger] = 'Mise à jour du projet impossible'
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end
    
    def logged_in_user
      unless logged_in?
        flash[:danger] = 'Connectez-vous SVP'
        redirect_to login_url
      end
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(
        :name,
        :number,
        :worker_id,
        :project_type,
        :owner_id,
        :description,
        :first_feedback,
        :delivery_date,
        :good_to_print,
        :feedback_number,
        :priority,
        :important,
        :progression,
        :archived,
        :state,
        :hours,
        :minutes,
        :departure_date,
        tasks_attributes: [:id, :description, :hours, :minutes, :_destroy, :worker_id, :project_id],
        feedbacks_attributes: [:id, :description, :_destroy, :worker_id, :project_id],
        participants_attributes: [:id, :project_id, :contact_id, :_destroy]
      )
    end
end
