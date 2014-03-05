class Event < ActiveRecord::Base
  permitted_attributes :title, :subtitle, :body, :highlight, :image, :start_at, :end_at
  AREAS = %w{catering landgasthaus}
  scope :active, -> {where(active: true)}
  mount_uploader :image, ImageUploader

  AREAS.each do |area|
    define_method("#{area}?") {
      self.area == "#{area}"
    }

    scope area, -> {where(area: area)}
  end

end
