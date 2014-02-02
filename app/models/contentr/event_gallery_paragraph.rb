module Contentr
  class EventGalleryParagraph < Contentr::Paragraph
      include ActionView::Helpers
      # Fields
      field :link_title, :type => 'String'
      field :body, :type => 'String'
      # Validations
    end
  end
