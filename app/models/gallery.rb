class Gallery < ActiveRecord::Base
  attr_accessor :images
  permitted_attributes :id, :title, :subtitle, :description, :images => []
  # RELATIONS
  has_many    :gallery_sliders
  has_many    :gallery_mappings, dependent: :destroy
  has_many    :gallery_images, dependent: :destroy
  has_many    :pdf_mappings, as: :owner

  # accepts_nested_attributes_for :gallery_images
  validates_presence_of :title
  validates_presence_of :subtitle
  validates_presence_of :description
end
