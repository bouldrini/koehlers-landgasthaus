module Contentr
  class GalleryTextParagraph < Contentr::Paragraph
      include ActionView::Helpers
      # Fields
      field :link_title, :type => 'String'
      field :gallery, :type => 'Integer'
      field :background_image, :uploader => Contentr::FileUploader
      field :body, :type => 'String'
      # Validations
    end
  end
