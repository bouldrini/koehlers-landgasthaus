module Contentr
  class TextImageParagraph < Contentr::Paragraph
      include ActionView::Helpers
      # Fields
      field :link_title, :typ => 'String'
      field :body, :typ => 'Text'
      field :image, :uploader => Contentr::FileUploader
      # Validations
    end
  end
