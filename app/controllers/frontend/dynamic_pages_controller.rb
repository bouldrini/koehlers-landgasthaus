class Frontend::DynamicPagesController < Frontend::ApplicationController
  def mount
    redirect_to  send("#{params[:namespace].downcase}_#{params[:routename].downcase}_path")
  end
end