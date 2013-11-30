# encoding: utf-8

  #rake create_default_page_configuration
task :create_default_page_configuration => :environment do

  lorem_ipsum = "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
  dummy_image = ImageAssetContentrTextImageParagraphImage.new()
  dummy_image.file = File.new("app/assets/images/imagedummy.jpg")
  dummy_image.save!

  landgasthaus_banner_image = ImageAssetContentrTextImageParagraphImage.new()
  landgasthaus_banner_image.file = File.new("app/assets/images/landgasthaus_banner.jpg")
  landgasthaus_banner_image.save!

  # GLOBAL ELEMENTS
  cms = Contentr::Site.new()
  cms.name = "cms"
  cms.slug = "cms"
  cms.position = nil
  cms.menu_only = nil
  cms.ancestry = nil
  cms.description = nil
  cms.menu_title = nil
  cms.published = true
  cms.hidden = false
  cms.layout = "frontend_app"
  cms.template = "default"
  cms.linked_to = nil
  cms.save!

  #HOME

  home = Contentr::LinkedPage.new()
  home.name = "Startseite"
  home.slug = "home"
  home.menu_only = nil
  home.type = "Contentr::LinkedPage"
  home.ancestry = nil
  home.description = nil
  home.menu_title = "Home"
  home.published = true
  home.hidden = false
  home.layout = "frontend_app"
  home.template = "default"
  home.linked_to = "frontend/pages#home"
  home.save!

  dummy_content = Contentr::BannerTextParagraph.new()
  dummy_content.area_name = "body"
  dummy_content.position = 1
  dummy_content.data = {"body" => lorem_ipsum, "image_id" => dummy_image.id, "link_title" => 'Banner | Text Abschnitt'}
  dummy_content.page = home
  dummy_content.save!
  dummy_content.publish!

  dummy_content = Contentr::ImageTextParagraph.new()
  dummy_content.area_name = "body"
  dummy_content.position = 2
  dummy_content.data = {"body" => lorem_ipsum, "image_id" => dummy_image.id, "link_title" => 'Bild | Text Abschnitt'}
  dummy_content.page = home
  dummy_content.save!
  dummy_content.publish!

  dummy_content = Contentr::TextImageParagraph.new()
  dummy_content.area_name = "body"
  dummy_content.position = 3
  dummy_content.data = {"body" => lorem_ipsum, "image_id" => dummy_image.id, "link_title" => 'Text | Bild Abschnitt'}
  dummy_content.page = home
  dummy_content.save!
  dummy_content.publish!

  #KONTAKT

  contact = Contentr::LinkedPage.new()
  contact.name = "Kontakt"
  contact.slug = "kontakt"
  contact.menu_only = nil
  contact.type = "Contentr::LinkedPage"
  contact.ancestry = nil
  contact.description = nil
  contact.menu_title = "Kontakt"
  contact.published = true
  contact.hidden = false
  contact.layout = "frontend_app"
  contact.template = "default"
  contact.linked_to = "frontend/pages#contact"
  contact.save!

  #IMPRESSUM

  impressum = Contentr::LinkedPage.new()
  impressum.name = "Impressum"
  impressum.slug = "impressum"
  impressum.menu_only = nil
  impressum.type = "Contentr::LinkedPage"
  impressum.ancestry = nil
  impressum.description = nil
  impressum.menu_title = "Impressum"
  impressum.published = true
  impressum.hidden = false
  impressum.layout = "frontend_app"
  impressum.template = "default"
  impressum.linked_to = "frontend/pages#impressum"
  impressum.save!

  impressum_text = Contentr::HtmlParagraph.new()
  impressum_text.area_name = "body"
  impressum_text.position = 1
  body = "<p><b style='color:#8B4726'>KÖHLERS LANDGASTHAUS</b></p><p>Karsten Köhler<br/>Rük 18 <br/>37581 Altgandersheim</p><p><b>Tel.: +49 5382 5212<br/>Fax: +49 5382 5259</b></p>E-Mail:<br/><p><b>landgasthauskoehler@gmail.com<br/>koehler.catering@gmail.com</b></p>STNR:  12/123/02750<div style='margin-top:20px'></div><p><b style='color:#8B4726'>KONZEPT, GESTALTUNG, CONTENT MANAGEMENT, HOSTING</b></p>Richard Wieditz, Marvin Köhler"
  impressum_text.data = {"body" => body}
  impressum_text.page = impressum
  impressum_text.save!
  impressum_text.publish!


  #ANFAHRT

  arrival = Contentr::LinkedPage.new()
  arrival.name = "Anfahrt"
  arrival.slug = "anfahrt"
  arrival.menu_only = nil
  arrival.type = "Contentr::LinkedPage"
  arrival.ancestry = nil
  arrival.description = nil
  arrival.menu_title = "Anfahrt"
  arrival.published = true
  arrival.hidden = false
  arrival.layout = "frontend_app"
  arrival.template = "default"
  arrival.linked_to = "frontend/pages#arrival"
  arrival.save!

  #GASTROKALENDER

  gastrokalender = Contentr::LinkedPage.new()
  gastrokalender.name = "Gastrokalender"
  gastrokalender.slug = "landgasthaus/gastrokalender"
  gastrokalender.menu_only = nil
  gastrokalender.type = "Contentr::LinkedPage"
  gastrokalender.ancestry = nil
  gastrokalender.description = nil
  gastrokalender.menu_title = "Gastrokalender"
  gastrokalender.published = true
  gastrokalender.hidden = false
  gastrokalender.layout = "frontend_app"
  gastrokalender.template = "default"
  gastrokalender.linked_to = "frontend/landgasthaus/pages#gastrokalender"
  gastrokalender.save!

  # GLOBAL MENU

  menu = Contentr::HtmlParagraph.new()
  menu.area_name = "nav"
  menu.position = 1
  body = "<li><a href='/home'><i class='fa fa-home'></i>&nbsp;&nbsp;Startseite</a></li><li><a class='dropdown-toogle' data-open='false' id='landgasthaus'><i class='fa fa-chevron-down'></i>&nbsp;&nbsp;Landgasthaus</a><ul type='none' class='dropdown' id='landgasthaus'><li><a href='/landgasthaus/gastrokalender'><i class='fa fa-calendar'></i>&nbsp;&nbsp;Gastrokalender</a></li><li><a href='/anfahrt'>Anfahrt</a></li></ul></li><li><a class='dropdown-toogle' data-open='false' id='catering'><i class='fa fa-chevron-down'></i>&nbsp;&nbsp;Catering</a><ul type='none' class='dropdown' id='catering'><li><a href='#fakelink'>Link</a></li></ul><li><a href='/kontakt'>Kontakt</a></li></li><li><a href='/impressum'>Impressum</a></li>"
  menu.data = {"body" => body}
  menu.page = cms
  menu.save!
  menu.publish!
end
