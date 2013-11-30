module Contentr
  class ImageTextParagraph < Contentr::Paragraph
      include ActionView::Helpers
      # Fields
      field :link_title, :type => 'String'
      field :image, :type => 'File', :uploader => Contentr::FileUploader
      field :body, :type => 'String'
      # Validations
    end
  end
