class GalleryMapping < ActiveRecord::Base
  belongs_to :gallery
  belongs_to :owner, polymorphic: true
end