module Contentr
  class TwoBlocksParagraph < Contentr::Paragraph
      include ActionView::Helpers

      # Fields
      field :link_title, :type => 'String'
      field :subtitle_one, :type => 'String'
      field :body_one, :type => 'String'
      field :subtitle_two, :type => 'String'
      field :body_two, :type => 'String'

      # Validations

    end
  end
