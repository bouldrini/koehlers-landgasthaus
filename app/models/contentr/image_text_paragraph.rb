module Contentr
  class ImageTextParagraph < Contentr::Paragraph
      include ActionView::Helpers
      # Fields
      field :link_title, :type => 'String'
      field :body, :type => 'String'
      field :background_image, :uploader => Contentr::FileUploader
      field :image, :uploader => Contentr::FileUploader
      # Validations
    end
  end
