class Frontend::PagesController < Frontend::ApplicationController
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
end
