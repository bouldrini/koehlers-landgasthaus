class Frontend::ApplicationController < ApplicationController
  layout 'frontend_app'
  before_filter :globalize_page
  before_filter :check_for_request_status

  protected
    def check_for_request_status
      unless session[:visited_lghk].present?
        session[:visited_lghk] = true
        s = Statistic.first
        s.count_requests = s.count_requests + 1
        s.save
      end
    end

    def globalize_page
      @page = Contentr::Page.find_by(slug: request.path[1..request.path.length].parameterize)
      @paragraphs = @page.paragraphs.select{|p| (p.area_name == 'body')} if @page.present?
    end
end
