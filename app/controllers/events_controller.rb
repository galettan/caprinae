class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # GET /events
  # GET /events.json
  def index
    day_of_the_week = Date.today
    first_day = day_of_the_week.at_beginning_of_year
    end_day = day_of_the_week.at_end_of_month + 6.month

    @filter_present = (params[:first_feedback].present? || params[:delivery_date].present? || params[:good_to_print].present? \
                      || params[:departure_date].present? || params[:team_events].present?)

    worker_filter = current_user.manager? ? '' : current_user.print? ? "AND project_type IN (1,3,6,7)" : "AND worker_id = '#{current_user.id}'"


    @events = Array.new
    if (params[:first_feedback].present? || !@filter_present)

      projects = Project.where("first_feedback >= '#{first_day.strftime("%Y-%m-%d")}'
       AND first_feedback <= '#{end_day}'" + worker_filter)
      projects.each do |project|
        @events << {
            title: project.number + ' - ' + project.name,
            url: project_url(project),
            date: project.first_feedback,
            color: 'DodgerBlue'
        }
      end
    end

    if (params[:delivery_date].present? || !@filter_present)
      projects = Project.where("delivery_date >= '#{first_day.strftime("%Y-%m-%d")}'
       AND delivery_date <= '#{end_day}'" + worker_filter)
      projects.each do |project|
        @events << {
            title: project.number + ' - ' + project.name,
            url: project_url(project),
            date: project.delivery_date,
            color: 'orange'
        }
      end
    end
    if (params[:good_to_print].present? || !@filter_present)
      projects = Project.where("good_to_print >= '#{first_day.strftime("%Y-%m-%d")}'
       AND good_to_print <= '#{end_day}'" + worker_filter)
      projects.each do |project|
        @events << {
            title: project.number + ' - ' + project.name,
            url: project_url(project),
            date: project.good_to_print,
            color: 'green'

        }
      end
    end
    if (params[:departure_date].present? || !@filter_present)
      projects = Project.where("departure_date >= '#{first_day.strftime("%Y-%m-%d")}'
       AND departure_date <= '#{end_day}'" + worker_filter)
      projects.each do |project|
        @events << {
            title: project.number + ' - ' + project.name,
            url: project_url(project),
            date: project.departure_date,
            color: 'YellowGreen'
        }
      end
    end
    if (params[:team_events].present? || !@filter_present)
      personnal_events = Event.all
      personnal_events.each do |personnal_event|
        @events << {
            title: personnal_event.title + ' - ' + personnal_event.user.login,
            url: personnal_event.user_id == current_user.id ? edit_event_url(personnal_event) : event_url(personnal_event),
            start: personnal_event.time_begin,
            end: personnal_event.time_end,
            color: 'GrayText',
            textColor: 'white'
        }
      end
    end

    @events = @events.to_json
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to events_path, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:user_id, :time_begin, :time_end, :title, :details)
    end
end
