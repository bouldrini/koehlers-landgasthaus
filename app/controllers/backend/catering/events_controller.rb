class Backend::Catering::EventsController < Backend::Catering::ApplicationController
  def index
    tabulatr_for Event.catering.order('title ASC')
  end
  def destroy
    event = Event.find(params[:id])
    event.destroy!
    redirect_to backend_catering_events_path
  end
  def new
    @event = Event.new
  end
  def edit
    @event = Event.find(params[:id])
  end
  def create
    if event_params[:type] == 'Collage'
      event = Collage.new(event_params)
    elsif event_params[:type] == 'Flyer'
      event = Flyer.new(event_params)
    end
    event.area = 'catering'
    event.active = true
    if event.save
      redirect_to backend_catering_events_path
    else
      raise event
    end
  end

  private
  def event_params
    params.require(:event).permit(*Event.permitted_attributes)
  end
end
