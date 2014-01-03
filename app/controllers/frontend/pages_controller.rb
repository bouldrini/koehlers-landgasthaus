class Frontend::PagesController < Frontend::ApplicationController
  before_filter :globalize_events
  def home
  end
  def arrival
    @json = [{
      description: 'Infotext für Mapmarker',
      lng: 10.040551,
      lat: 51.905123
    }].to_json
    @lng = 10.040551
    @lat = 51.905123
  end
  def contact
  end
  def impressum
  end
  def playground
  end
  protected
    def globalize_events
      @events = Event.all[0...3]
    end
end
