module Contentr
  class TextImageParagraph < Contentr::Paragraph
      include ActionView::Helpers
      # Fields
      field :link_title, :type => 'String'
      field :body, :type => 'String'
      field :image, :type => 'File', :uploader => Contentr::FileUploader
      # Validations
    end
  end
