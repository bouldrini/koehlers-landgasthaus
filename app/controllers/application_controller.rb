class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  layout 'backend_app'
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    backend_dashboard_path
  end
  protected
    def contentr_authorized?
      current_user.present? ? true : false
    end

    def contentr_publisher?
      current_user.present? ? true : false
    end
end
