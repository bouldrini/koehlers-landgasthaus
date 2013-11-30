class Event < ActiveRecord::Base
  permitted_attributes :title, :subtitle, :body, :highlight, :type
end