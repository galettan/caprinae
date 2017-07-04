class ActivitiesController < ApplicationController
  before_action :logged_in_user
  before_action :manager_user, only: [:index]



  def index
    today = Date.today # Today's date
    monday = today.at_beginning_of_week
    friday = monday + 4.days
    @activities = Task
                      .select('tasks.created_at, sum(duration) as duration, tasks.project_id, tasks.worker_id')
                      .joins(:worker)
                      .joins(:project)
                      .where("tasks.created_at >= '#{monday.strftime("%Y-%m-%d")} 00:00:00'
  AND tasks.created_at <= '#{friday} 23:59:59'")
                      .group('tasks.created_at')
    @days_from_this_week = (today.at_beginning_of_week..friday).map
    @act = Hash.new()
    @activities.each do |activity|
      @act[activity.created_at.strftime("%d-%m-%Y")] = Hash.new unless @act.key?(activity.created_at.strftime("%d-%m-%Y"))
      @act[activity.created_at.strftime("%d-%m-%Y")][activity.worker] = Hash.new unless @act[activity.created_at.strftime("%d-%m-%Y")].key?(activity.worker)
      if (@act[activity.created_at.strftime("%d-%m-%Y")][activity.worker].key?('total'))
        @act[activity.created_at.strftime("%d-%m-%Y")][activity.worker]['total'] += activity.duration
        if (@act[activity.created_at.strftime("%d-%m-%Y")][activity.worker]['details'].key?(activity.project))
          @act[activity.created_at.strftime("%d-%m-%Y")][activity.worker]['details'][activity.project] += activity.duration
        else
          @act[activity.created_at.strftime("%d-%m-%Y")][activity.worker]['details'][activity.project] = activity.duration
        end
      else
        @act[activity.created_at.strftime("%d-%m-%Y")][activity.worker]['total'] = activity.duration
        @act[activity.created_at.strftime("%d-%m-%Y")][activity.worker]['details'] = Hash.new()
        @act[activity.created_at.strftime("%d-%m-%Y")][activity.worker]['details'][activity.project] = activity.duration
      end
    end


  end

  private
    def manager_user
      unless (current_user.manager?)
        flash[:danger] = 'Vous n\'avez pas les permissions nécessaires pour accéder à cette page'
        redirect_to root_path
      end
    end

  def logged_in_user
    unless logged_in?
      flash[:danger] = 'Connectez-vous SVP'
      redirect_to login_url
    end
  end

end