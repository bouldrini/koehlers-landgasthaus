module Contentr
  class FourBlocksParagraph < Contentr::Paragraph
      include ActionView::Helpers

      # Fields
      field :link_title, :type => 'String'
      field :title_one, :type => 'String'
      field :body_one, :type => 'String'
      field :title_two, :type => 'String'
      field :body_two, :type => 'String'
      field :title_three, :type => 'String'
      field :body_three, :type => 'String'
      field :title_four, :type => 'String'
      field :body_four, :type => 'String'
      field :image, :uploader => Contentr::FileUploader

      # Validations

    end
  end
