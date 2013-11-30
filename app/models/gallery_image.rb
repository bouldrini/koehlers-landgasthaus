class GalleryImage < ActiveRecord::Base
  permitted_attributes :image, :gallery

  # RELATIONS
  belongs_to    :gallery

  mount_uploader :image, ImageUploader

  def self.link(img, gal)
    image = GalleryImage.new(:image => img, :gallery => gal)
    image.save
  end
end