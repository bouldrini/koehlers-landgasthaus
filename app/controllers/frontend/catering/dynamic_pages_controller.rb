class Frontend::Catering::DynamicPagesController < Frontend::Catering::ApplicationController
  Page.catering.each do |page|
    define_method page.title.downcase.to_sym do
      render :file => "layouts/dynamic_app", :layout => false
    end
  end
end