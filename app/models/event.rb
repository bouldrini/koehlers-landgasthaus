class Event < ActiveRecord::Base
  permitted_attributes :title, :subtitle, :body, :highlight, :type, :image, :start_at, :end_at
  TYPES = %w{collage flyer}
  AREAS = %w{catering landgasthaus}
  scope :active, -> {where(active: true)}

  TYPES.each do |type|
    define_method("#{type}?") {
      self.type == "#{type.capitalize}"
    }

    scope type, -> {where(type: type.capitalize)}
  end

  AREAS.each do |area|
    define_method("#{area}?") {
      self.area == "#{area}"
    }

    scope area, -> {where(area: area)}
  end

end
