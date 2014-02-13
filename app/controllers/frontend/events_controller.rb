class Frontend::EventsController < Frontend::ApplicationController
  def show
    @event = Event.find(params[:id])
  end
end
