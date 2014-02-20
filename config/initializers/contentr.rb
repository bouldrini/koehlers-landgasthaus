# coding: utf-8

Contentr.setup do |config|
  config.site_name    = 'My Dummy Site'
  config.default_page = 'home'
  # config.default_site = 'cms'
  # config.google_analytics_account = ''
  # config.register_paragraph(Contentr::TextImageParagraph, 'Text | Bild - Element')
  # config.register_paragraph(Contentr::ImageTextParagraph, 'Bild | Text - Element')
  # config.register_paragraph(Contentr::BannerTextParagraph, 'Banner | Text - Element')
  # config.register_paragraph(Contentr::GalleryTextParagraph, 'Gallerie | Text - Element')
  config.register_paragraph(Contentr::OneBlockParagraph, 'Ein Block Paragraph')
  config.register_paragraph(Contentr::TwoBlocksParagraph, 'Zwei Blöcke Paragraph')
  config.register_paragraph(Contentr::ThreeBlocksParagraph, 'Drei Blöcke Paragraph')
  config.register_paragraph(Contentr::FourBlocksParagraph, 'Vier Blöcke Paragraph')
  config.register_paragraph(Contentr::FiveBlocksParagraph, 'Five Blöcke Paragraph')
  config.register_paragraph(Contentr::ScrollerImageParagraph, 'Titelbild - Element (nicht verwenden!)')
  config.register_paragraph(Contentr::EventGalleryParagraph, 'Eventgallerie (max. eine)')
  config.additional_admin_stylesheets << 'frontend/contentr_stylesheet'
  config.additional_admin_javascripts << 'frontend/contentr_javascript'
end
