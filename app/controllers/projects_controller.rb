class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:edit, :update, :index, :destroy]

  # GET /projects
  # GET /projects.json
  def index
    @clients = Client.all
    @projects = Project.where(nil)
    @projects = @projects.passed(params[:archived]).paginate(page: params[:page]) if params[:archived].present?
    @projects = @projects.number(params[:number]).paginate(page: params[:page]) if params[:number].present?
    if params[:user_id].present?
      if (params[:user_id] == 'all')
        @projects = Project.where(nil).paginate(page: params[:page])
      else
        @projects = @projects.user(params[:user_id]).paginate(page: params[:page])
      end
    end
    @projects = @projects.search_name(params[:name]).paginate(page: params[:page]) if params[:name].present?
    @projects = @projects.client(params[:client_id]).paginate(page: params[:page]) if params[:client_id].present?
    @projects = @projects.create_date(params[:create_date], params[:create_date].to_date + 1.day).paginate(page: params[:page]) if params[:create_date].present?
    @projects = @projects.project_type(params[:project_type]).paginate(page: params[:page]) if params[:project_type].present?
    @projects = @projects.progress(params[:progress]).paginate(page: params[:page]) if params[:progress].present?
    @projects = @projects.status(params[:state]).paginate(page: params[:page]) if params[:state].present?
    @projects = @projects.prio(params[:priority]).paginate(page: params[:page]) if params[:priority].present?
    if ((!params[:archived].present? && !params[:number].present? && !params[:user_id].present? && !params[:name].present? && !params[:client_id].present? &&
      !params[:create_date].present? && !params[:project_type].present? && !params[:progress].present? && !params[:pstate] && !params[:priority]))
      if current_user.manager?
        @projects = Project.by_owner(current_user.id).order(priority: :desc, number: :desc).paginate(page: params[:page])
      elsif current_user.crea?
        @projects = Project.for_crea(current_user.id).order(priority: :desc, number: :desc).paginate(page: params[:page])
      else
        @projects = Project.for_print().order(priority: :desc, number: :desc).paginate(page: params[:page])
      end
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
    @client = Client.all
    @project = Project.new(project_params)

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
    @tasks = project_params['tasks_attributes']
    @project_data = project_params
    @feedbacks = project_params['feedbacks_attributes']
    if !@tasks.nil?
      @tasks.each do |t|
        t[1]['worker_id'] = current_user.id if t[1]['id'].nil?
      end
      @project_data['tasks_attributes'] = @tasks
    end
    if !@feedbacks.nil?
      @feedbacks.each do |f|
        f[1]['worker_id'] = current_user.id if f[1]['id'].nil?
      end
      @project_data['feedbacks_attributes'] = @feedbacks
    end
    respond_to do |format|
      if @project.update(@project_data)
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
        :open_shape,
        :test_print,
        :colors,
        :various_input,
        :good_sheets_qty,
        :finished_doc_qty,
        :let_raw,
        :finished_shape,
        :filming,
        :shaping,
        :package,
        :delivery,
        :notice,
        :outsourcing,
        tasks_attributes: [:id, :description, :hours, :minutes, :_destroy, :worker_id, :project_id],
        feedbacks_attributes: [:id, :description, :_destroy, :worker_id, :project_id],
        participants_attributes: [:id, :project_id, :contact_id, :_destroy],
        papers_attributes: [:id, :project_id, :shape, :density, :paper, :_destroy, :note]
      )
    end
end
