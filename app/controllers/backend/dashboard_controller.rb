class Backend::DashboardController < Backend::ApplicationController
  def index
    @stats = Statistic.first
  end
end
