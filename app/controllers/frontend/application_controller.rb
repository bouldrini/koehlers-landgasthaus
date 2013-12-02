class Frontend::ApplicationController < ApplicationController
  layout 'frontend_app'
  before_filter :globalize_page
  protected
    def globalize_page
      @page = Contentr::Page.find_by(slug: request.path[1..request.path.length].parameterize)
      @paragraphs = @page.paragraphs.select{|p| (p.area_name == 'body' && p.body.present?)}
    end
end
