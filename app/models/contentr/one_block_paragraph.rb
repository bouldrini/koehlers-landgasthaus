module Contentr
  class OneBlockParagraph < Contentr::Paragraph
      include ActionView::Helpers

      # Fields
      field :link_title, :type => 'String'
      field :title_one, :type => 'String'
      field :body_one, :type => 'String'
      field :background_image, :uploader => Contentr::FileUploader

      # Validations

    end
  end
