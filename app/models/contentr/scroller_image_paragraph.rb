module Contentr
  class ScrollerImageParagraph < Contentr::Paragraph
      include ActionView::Helpers
      # Fields
      field :desktop_image, :uploader => Contentr::FileUploader
      field :tablet_image, :uploader => Contentr::FileUploader
      field :phone_image, :uploader => Contentr::FileUploader
      # Validations
    end
  end
