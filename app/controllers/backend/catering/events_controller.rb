class Backend::Catering::EventsController < Backend::Catering::ApplicationController
  def index
    tabulatr_for Event.order('title ASC')
  end
end