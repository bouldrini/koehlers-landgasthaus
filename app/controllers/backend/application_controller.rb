class Backend::ApplicationController < ApplicationController
  protect_from_forgery
  before_filter :authenticate_user
  layout "backend_app"
  protected
    def authenticate_user
      current_user.present? ? true : redirect_to(backend_path)
    end
end
