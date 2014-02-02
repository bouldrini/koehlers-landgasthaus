module Contentr
  class ScrollerImageParagraph < Contentr::Paragraph
      include ActionView::Helpers
      # Fields
      field :image, :uploader => Contentr::FileUploader
      # Validations
    end
  end
