class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  #rescue_from Exception, :with => :render_404

  private

  def render_404
    render :template => 'error_pages/404', :layout => false, :status => :not_found
  end
end
