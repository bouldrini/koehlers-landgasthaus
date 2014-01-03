class Backend::Landgasthaus::EventsController < Backend::Landgasthaus::ApplicationController
  def index
    tabulatr_for Event.landgasthaus.order('title ASC')
  end
  def destroy
    event = Event.find(params[:id])
    event.destroy!
    redirect_to backend_landgasthaus_events_path
  end

  def new
    @event = Event.new
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    event = Event.find params[:id]
    if event.update(event_params)
      redirect_to backend_landgasthaus_events_path
    else
      render :edit
    end
  end

  def create
    if event_params[:type] == 'Collage'
      event = Collage.new(event_params)
    elsif event_params[:type] == 'Flyer'
      event = Flyer.new(event_params)
    end
    event.active = true
    event.area = 'landgasthaus'
    if event.save
      redirect_to backend_landgasthaus_events_path
    else
      raise event
    end
  end

  private
  def event_params
    params.require(:event).permit(*Event.permitted_attributes)
  end
end
