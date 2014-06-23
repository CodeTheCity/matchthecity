class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  private

  def require_login
    flash[:error] = "That function is not available"
    redirect_to welcome_index_url
  end
end
