# encoding: utf-8

  #rake create_default_page_configuration
task :create_default_page_configuration => :environment do

  lorem_ipsum = "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."

  # landgasthaus_banner_image = ImageAssetContentrTextImageParagraphImage.new()
  # landgasthaus_banner_image.file = File.new("app/assets/images/landgasthaus_banner.jpg")
  # landgasthaus_banner_image.save!

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

  # SCHLEMMEN UNTER'M SCHINDELDACH

  sliderhome = Contentr::EventGalleryParagraph.new()
  sliderhome.area_name = "body"
  sliderhome.position = 2
  sliderhome.data = {"link_title" => "Aktuelles"}
  sliderhome.page = home
  sliderhome.save!
  sliderhome.publish!

  schlemmen_unterm_schindeldach = Contentr::OneBlockParagraph.new()
  schlemmen_unterm_schindeldach.area_name = "body"
  schlemmen_unterm_schindeldach.position = 1
  body = "<p>Unsere 'Schlemmermeile' reicht von der <br/>landhaustypischen Vorspeise, mediterranen Antipasti<br/>gepaart mit interessantem aus dem Meer,<br/>über eine vitamin reiche und kreative Salatbar,<br/>hin zu einer regionalen wie geschmackvollen Auswahl<br/>an Fleisch und Fisch-Spezialitäten - Egal ob frisch gegrillt,<br/>gebraten oder aus dem Steinbackofen.<br/><br/>Allerlei Marktgemüse, sowie bodenständiges von der Kartoffel<br/>und aus der Pasta-Ecke runden das Ganze ab.<br/>Vorweg oder zwischendurch warten in unserem Suppentopf<br/>Klassiker und raffinierte Kreationen.<br/>Zum Abschluss gönnen Sie sich eine kleine Sünde<br/>aus der süßen Ecke oder etwas von unseren Käsespezialitäten<br/>mit hausgebackenem Steinofenbrot.<br/><p/><br/><br/><br/><br/><p><br/>Jeden Samstag ab 18:00 Uhr<br/>Sonntags & Feiertags ab 11:30 bis 14:00 Uhr<br/><br/>...am besten immer Vorbestellen!<br/><p/>"
  price = "Pro Person ab 16,50 €"
  schlemmen_unterm_schindeldach.data = {"title_one" => "Schlemmen unter'm Schindeldach","body_one" => body, "link_title" => "Schlemmen unter'm Schindeldach"}
  schlemmen_unterm_schindeldach.page = home
  schlemmen_unterm_schindeldach.save!
  schlemmen_unterm_schindeldach.publish!

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

  #ERHOLUNG & KULTUR

  erholungundkultur = Contentr::LinkedPage.new()
  erholungundkultur.name = "Erholung & Kultu"
  erholungundkultur.slug = "landgasthaus/erholungundkultur".parameterize
  erholungundkultur.menu_only = nil
  erholungundkultur.type = "Contentr::LinkedPage"
  erholungundkultur.ancestry = nil
  erholungundkultur.description = nil
  erholungundkultur.menu_title = "Erholung & Kultur"
  erholungundkultur.published = true
  erholungundkultur.hidden = false
  erholungundkultur.layout = "frontend_app"
  erholungundkultur.template = "default"
  erholungundkultur.linked_to = "frontend/landgasthaus/pages#erholungundkultur"
  erholungundkultur.save!

  # HOTEL

  hotel = Contentr::LinkedPage.new()
  hotel.name = "Hotel"
  hotel.slug = "landgasthaus/hotel".parameterize
  hotel.menu_only = nil
  hotel.type = "Contentr::LinkedPage"
  hotel.ancestry = nil
  hotel.description = nil
  hotel.menu_title = "Hotel"
  hotel.published = true
  hotel.hidden = false
  hotel.layout = "frontend_app"
  hotel.template = "default"
  hotel.linked_to = "frontend/landgasthaus/pages#hotel"
  hotel.save!

  # FEIERLICHKEITEN

  feierlichkeiten = Contentr::LinkedPage.new()
  feierlichkeiten.name = "Feierlichkeiten"
  feierlichkeiten.slug = "landgasthaus/feierlichkeiten".parameterize
  feierlichkeiten.menu_only = nil
  feierlichkeiten.type = "Contentr::LinkedPage"
  feierlichkeiten.ancestry = nil
  feierlichkeiten.description = nil
  feierlichkeiten.menu_title = "Feierlichkeiten"
  feierlichkeiten.published = true
  feierlichkeiten.hidden = false
  feierlichkeiten.layout = "frontend_app"
  feierlichkeiten.template = "default"
  feierlichkeiten.linked_to = "frontend/landgasthaus/pages#feierlichkeiten"
  feierlichkeiten.save!

  feier_im_landgasthaus = Contentr::OneBlockParagraph.new()
  feier_im_landgasthaus.area_name = "body"
  feier_im_landgasthaus.position = 1
  body = '<p>Besonders für feierliche und unvergessliche Augenblicke bietet das Landgasthaus mit seinem landhaustypischen Ambiente und seinem kulinarischen Können den passenden Rahmen. Wir stellen uns auf jeden Anlass individuell ein und bieten ein maßgeschneidertes Event, ganz nach Ihrem Geschmack.</p><p>Hier bleibt kaum ein Wunsch unerfüllt und kein Bedürfnis unberücksichtigt. Wählen Sie aus unseren genüsslichen Angeboten Ihre Kulinarischen Favoriten. Erleben Sie eine regionale wie auch moderne Küche mit leckeren Produkten aus der Region. Der Faktor des Wohlfühlens ist nicht zu unterschätzen, wenn es darum geht, eine Feier auszurichten, an die sich die Gäste noch zurück erinnern sollen. Das landhaustypische Ambiente mit mit <b>Schlemmen unter’m Schindeldach</b>, die liebevoll gestaltete Buffetlandschaft und zu guter Letzt unsere engagierten Mitarbeiter aus Küche und Service verwandeln jede Veranstaltung und Ihre private Feier in eine schöne in Erinnerung bleibende Begegnung.</p><p>Nennen Sie uns einfach Ihre Wünsche – wir antworten mit köstlichen Ideen, individuellen Angeboten, liebevollem Service und einem variablem Raumangebot, in dem wir für bis zu 200 Gästen die schönsten Pläte bereithalten.</p><p>Ihre Familie Köhler & Team</p>'
  feier_im_landgasthaus.data = {"link_title" => "Feiern im Landgasthaus", "title_one" => "Feiern im Landgasthaus", "body_one" => body}
  feier_im_landgasthaus.page = feierlichkeiten
  feier_im_landgasthaus.save!
  feier_im_landgasthaus.publish!

  landhaus = Contentr::FiveBlocksParagraph.new()
  landhaus.area_name = "body"
  landhaus.position = 2
  body_one = "Carpaccio von der Roten Beete mit Blauschimmelkäse<br/>Räucherlachs mit Sahnemeerrettich<br/>Serranoschinken mit Honigmelone<br/>Tomate & Mozzarella mit Balsamico mariniert & Basilikum<br/>Steinofenbrot & Baguette"
  body_two = "Jahreszeitliche Blattsalate<br/>Tomatensalat, Gurkensalat mit Dill<br/>Karottensalat, Paprikasalat mit Feta<br/>Weißkohlsalat mit Schmand<br/>verschiedene Dressings & Essig/Öl"
  body_three = "<p>Kleine gefüllte Schweineröllchen im Salbeirahm<br/>Hähnchenbrustschnitzel Tessiner Art<br/>mit Tomate & Käse überbacken<br/>Geschmortes aus der Rinderkeule mit<br/>Rotweinjus & gebratenen Champignons<br/>Pochiertes Lachsfilet auf Gemüsejulienne & Sauce béarnaise</p><p>Buntes Marktgemüse mit Sauce hollandaise<br/>Grüne Bohnen mit Speck & Apfelrotkohl</p><p>Schwenkkartoffeln, Kartoffelklöße,<br/>Langkornreis & Kartoffelkroketten</p>"
  body_four = "Rinderkraftbrühe mit Suppenklößchen,<br/>Eierstich, Gemüsejulienne & Petersilie"
  body_five = "Cremedessert von Schokolade, Erdbeer & Mango<br/>Hausgemachte Rote Grütze<br/>Eiscreme & Vanillesoße<br/>Käsebrett mit Weintrauben"
  price = "pro Person ab 23,50 €"
  landhaus.data = {"link_title" => "Landhaus *", "title_one" => 'Kaltes ...', "body_one" => body_one, "title_two" => "Salatbuffet ...", "body_two" => body_two, "title_three" => "Warmes ...", "body_three" => body_three, "title_four" => "Suppentopf ...", "body_four" => body_four, "title_five" => 'Süßes ...' ,"body_five" => body_five }
  landhaus.page = feierlichkeiten
  landhaus.save!
  landhaus.publish!

  landhaus_two = Contentr::FiveBlocksParagraph.new()
  landhaus_two.area_name = "body"
  landhaus_two.position = 3
  body_one = "<p>Graved Lachs mit Honig-Senf-Dill-Tunke<br/> Meeresfrüchten mit Kapern, Zwiebeln & Paprika<br/> Rosa Gebratenes vom Rind mit Remouladensoße<br/>Peperone, Kleine Paprika & Champignons eingelegt und mit Frischkäse gefüllt Steinofenbrot & Baguette</p>"
  body_three = "<p>Schweinefilet mit Rahmsoße & gebratenen Champignons <br/>Supreme von der Pouladenbrust mit Limonensoße & glacierten Kirschtomaten Hirschkalbskeulenbraten mit Wacholderrahm<br/>Preselbeeren & Waldpilzen, gebratenes Zanderfilet auf Blattspinat</p><p>Gartengemüse mit Sauce hollandaise<br/>Speckrosenkohl & Apfelrotkohl</p><p>Rosmarinkartoffeln, Butterspätzle & Wildreis, Kartoffelkroketten & Röstitaler</p>"
  bobdy_two = "<p>Tomatenrahmsuppe mit Sahne & Basilikum</p>"
  body_four = "<p>Jahreszeitliche Blattsalate<br/> Tomatensalat<br/>Gurkensalat mit Dill<br/>Karottensalat<br/>Paprikasalat mit Feta<br/>Weißkohlsalat mit Schmand<br/>Dressing & Essig/Öl</p>"
  body_five = "<p>Cremedesserts von Schokolade, Limette & Himbeer<br/>Hausgemachte Rote Grütze</p><p>Frischer Obstsalat<br/>Eiscreme & Vanillesoße<br/>Käsebrett mit Weintrauben</p>"
  price = "pro Person ab 24,50 €"
  landhaus_two.data = {"link_title" => "Landhaus **", "title_one" => 'Kaltes ...', "body_one" => body_one, "title_two" => "Suppentopf ...", "body_two" => body_two, "title_three" => "Warmes ...", "body_three" => body_three, "title_four" => "Salatbuffet ...", "body_four" => body_four, "title_five" => "Süßes ...", "body_five" => body_five}
  landhaus_two.page = feierlichkeiten
  landhaus_two.save!
  landhaus_two.publish!

  bayrisch = Contentr::ThreeBlocksParagraph.new()
  bayrisch.area_name = "body"
  bayrisch.position = 4
  body_one = "<p>Geräuchter Schinken & Schinkenspeck<br/>mit Schmalz & Radieschen</p><p>Allgäuer Käsebrett mit Trauben, Obazter, Radi & Brezeln<br/>Deftiger Wurstalat mit ofenfrischem Krustenbrot & Butter</p>"
  body_three = "<p>Dampfnudeln mit Mohnbutter</p><p>Bayrischcreme mit Himbeercocktail</p><p>Beschwipste Zwetschgen mit Vanilleeis</p>"
  body_two = "<p>Spanferkel mit Jus, Weinsauerkraut und Semmelknödel</p><p>Gepökelte Ochsenbrust mit Meerrettich Soße und Bouillonkartoffeln</p><p>Haxenfleisch in Braunbiersoße und Kartoffelklöße</p><p>Weißwürste mit bayrischem Kartoffelsalat und süßem Senf</p>"
  price = "pro Person ab 19,50 €"
  bayrisch.data = {"link_title" => "Bayrisch", "title_one" => 'Kaltes ...', "body_one" => body_one, "title_two" => "Warmes ...", "body_two" => body_two, "title_three" => "Süßes ...", "body_three" => body_three}
  bayrisch.page = feierlichkeiten
  bayrisch.save!
  bayrisch.publish!

  mai = Contentr::FourBlocksParagraph.new()
  mai.area_name = "body"
  mai.position = 5
  body_one = "<p>Duett vom Grünen & Weißen Spargel kalt mariniert mit Shrimps & Kräuter Hausgebeizter Graved Lachs mit Senf-Dill Tunke</p><p>Cherry Strauchtomaten gegrillt mit Mozzarella Bällchen Schinkenvariationen vom Schwarzwälder, gekochten & Serranoschinken</p><p>Hausgebackenes Steinofenbrot & Baguette</p>"
  body_two = "<p>Cremesuppe vom frischen Spargel mit Sahne & Petersilie</p>"
  body_three = "<p>Frischer deutscher Stangenspargel aus <b>aus Gilten in der Heide</b> mit Sauce hollandaise & Butter</p><p>Kleine panierte Schweineschnitzel Gebratenes Lachsfilet mit buntem Pfeffer & Zitrone Medaillons vom Schweinefilet in leichtem Pfefferrahm Gegrillte Hähnchenbrust mit Limonensauce</p><p>Petersilienkartoffeln, Kartoffelgratin & Röstitaler</p>"
  body_four = "<p>Variationen von der Erdbeere</p>"
  price = "pro Person ab 26,50 €"
  mai.data = {"link_title" => "Spargelzeit", "title_one" => 'Kaltes ...', "body_one" => body_one, "title_two" => "Suppentopf ...", "body_two" => body_two, "title_three" => "Warmes ...", "body_three" => body_three, "title_four" => 'Süßes ...', "body_four" => body_four}
  mai.page = feierlichkeiten
  mai.save!
  mai.publish!

  mediterran = Contentr::FourBlocksParagraph.new()
  mediterran.area_name = "body"
  mediterran.position = 6
  body_one = "<p>Antipasti vom Gemüse<br/>Gegrillte Aubergine mit eingelegten Tomaten & Danablue Käse<br/>Gebratene Zucchini mit Basilikum, Zitonen-Pfeffer-Karotten mit Minze<br/>Paprika gebraten & mariniert, Champignons mit Chilli, Balsamico Zwiebeln<br/>Aubergine in Parmesan Eihülle, Tomaten & Mozarella<br/>Spanische Mini Salzkartoffeln, Meeresfrüchtesalat mit Kapern<br/>Serranoschinken & Melone, Spinata alla Romana<br/>Tintenfisch pikant in Tomate mit Oliven & Zwiebeln</p><p>Blattsalat der Saison mit Kirschtomaten, Gurke, Zwiebeln<br/>Karottenstreifen & Kräuter<br/>Dressings & Essig Öl & hausgebackenes Baguette</p>"
  body_two = "<p>Paella mit Scampi & Muscheln<br/>Fisch, Meeresfrüchte & Hühnchen<br/>Saltimbokka vom Schweinefilet mit<br/>Schinken & Salbei in leichter Weinsoße</p>"
  body_three = "<p>Lammkeule frisch am Buffet tranchiert<br/>mit Knoblauch-Rosmarin Jus<br/>Gebratenes Hühnchen mit Zucchini<br/>Zwiebeln, Küstentomaten, Oliven & Thymian</p><p>Spaghetti mit Knobi & Peperoni<br/>Gebratene Kartoffeln mit Olivenöl<br/>buntem Pfeffer & Kräuter<br/>Pasta mit Cocktailtomaten & Basilikum<br/>Rosmarin Kartoffeln</p>"
  body_four = "<p>Tiramisu & Panna Cotta mit Beere<br/>Käsespezialitäten aus Italien mit Obst<br/>Gelato</p>"
  price = "pro Person ab 26,50 €"
  mediterran.data = {"link_title" => "Mediterran", "title_one" => 'Kaltes ...', "body_one" => body_one, "title_two" => "Aus dem Steinbackofen ...", "body_two" => body_two, "title_three" => "Warmes ...", "body_three" => body_three, "title_four" => 'Süßes ...', "body_four" => body_four}
  mediterran.page = feierlichkeiten
  mediterran.save!
  mediterran.publish!

  kaffee = Contentr::TwoBlocksParagraph.new()
  kaffee.area_name = "body"
  kaffee.position = 7
  body_one = "<p>Ihre Feier beginnt am Nachmittag mit Kaffee und Kuchen?<br/>Sie haben die Möglichkeit ihre selbst gebackenen Kuchen von Zuhause mitzubringen oder Sie lassen einfach ihre Kuchen und Torten von unserm Konditormeister bei uns im Haus backen. Gerne bieten wir ihnen dazu eine Kaffeepauschale an. Sprechen Sie uns an!</p><p>Hochzeitstorten Nachmittags oder um Mitternacht?<br/>Kein Problem!<br/>Unser Konditormeister fertigt ihre Hochzeitstorte gerne speziell nach ihren Wünschen an<br/>Ob in Herzform, mehrere Etagen mit und ohne Marzipan oder frische Rosen verzieren ihre Schneeweiße Hochzeitstorte ganz Individuell und nach ihren Wünschen</p>"
  body_two ="<p>Den ganzen Abend feucht fröhlich gefeiert und getanzt, da kommt gerne noch einmal der kleine Hunger zurück ...</p><p><ul><li>Mitternachtssuppe</li><li>Spiegeleier frisch gebraten</li><li>Strammer Max mit Schinken & Ei</li><li>Currywurst</li><li>und und und...</li></ul></p><p>Alle unsere Angebote sind ab 20 Personen buchbar und beinhalten den eingedeckten Tisch (ohne Blumengesteck) mit Tischdecke, Servietten, Besteck und Kerzen - auf Wunsch mit Platztellern - sowie den Service und die z. Zt. gültige Mehrwertsteuer.<br/>Sollte dennoch kein Angebot ihren Wünschen entsprechen, erstellen wir gerne ein individuell auf ihre Bedürfnisse zugeschnittenes Angebot mit Preis & Gestaltung.</p><p>Wie helfen bei der Auswahl des DJs oder Alleinunterhalters, kümmern uns um den Blumenschmuck bzw. die Vermittlung zu einem am Ort gelegenen Blumengeschäfts oder Floristen und vieles mehr ...</p><p>Gastlichkeit auf die besondere Art genießen. Egal ob bei uns im Haus, bei Ihnen im Haus oder wo Sie am liebsten Feiern möchten, wir sind gern ihr verlässlicher Partner</p><p>Ihre Familie Köhler & Team</p>"
  kaffee.data = {"link_title" => "Kaffee & Kuchen", "title_one" => 'Kaffee & Kuchen ...', "body_one" => body_one, "title_two" => "Mitternachtssnack ...", "body_two" => body_two}
  kaffee.page = feierlichkeiten
  kaffee.save!
  kaffee.publish!

  getraenke = Contentr::TwoBlocksParagraph.new()
  getraenke.area_name = "body"
  getraenke.position = 8
  body_one = "<p> <h5 class='brown'>Aperitf ...</h4>Sekt, Orangensaft, Prosecco & Aperol</p><p>  <h5 class='brown'>Alkoholfreie Getränke ...</h4>Coca Cola, Coca Cola light, Spezi, Fanta & ApfelschorleBitter Lemon, Orangensaft, Apfelsaft & Apollinaris Mineralwasser</p><p>  <h5 class='brown'>Biere ...</h4>Bitburger Pils, Alsterwasser & Bitburger 0,0Paulaner Weißbierhell, dunkel, kristall & alkoholfrei</p><p>  <h5 class='brown'>Wein & Sekt ...</h4>Unser Hauswein vom Weingut KöhlerRheinhessen, QbAGrauburgunder, Silvaner, Dornfelder & SpätburgunderRose ...Sekt & Prosecco</p><p>  <h5 class='brown'>Kaffee ...</h4>Kaffee, Espresso, Cappuccino, Latte Macchiato & Tee</p><p>  <h5 class='brown'>Spirituosen ...</h4>Ouzo, Malteser Aquavit, Doppelkorn, Obstler,Fernet Branca, Ramazotti, Jägermeister,Wildkirscj, Baileys & Eierlikör</p><p><p>Preis pro Person ab 24,50 €(für die Dauer von 7 Stunden</p></p>"
  body_two = "<p>beinhaltet die Getränkepauschale Landhaus plus zusätzlich</p><p>Wodka Gorbatschow<br/>Jim Beam<br/>Bacardi<br/>Havanna Club<br/>Gordon's Gin</p><p>als Longdrink mit</p><p>Coca Cola, Sprite, Fanta, Orangensaft,Bitter Lemon & Tonic Water</p><p>Preis pro Person ab 29,50 €(für die Dauer von 7 Stunden)</p>"
  body_three ="<p>Klassisch:</p><p>Es wird jedes Getränk einzeln berechnet.</p><p>Getränkepauschale Landgasthaus:</p><p>Ihre Gäste können für die Zeit von 7 Stunden (z.B. 19.00 - 2.00 Uhr) soviele Getränke aus der Landhauspauschale zu sich nehmen wie Sie möchten.Nach Ablauf der sieben Stunden, berechnen wir für jede weitere volle Stunde GetränkepauschaleLandhaus € 100,-.</p><p>Getränkepauschale Longdrinks:</p><p>Die Getränkepauschale Longdrinks beinhaltet die Getränkepauschale Landhaus sowie alle aufgeführten Longdrinks für die Zeitvon 7 Stunden (z.B. 19.00 - 2.00 Uhr).Nach Ablauf der sieben Stunden berechnen wir für jede weitere volle Stunde Getränkepauschale Longdrinks € 150,-.</p>"
  getraenke.data = {"link_title" => "Getränke", "subtitle_one" => 'Getränkepauschale Landhaus ...', "subtitle_two" => "Getränkepauschale Landgasthaus", "body_one" => body_one, "subtitle_two" => "Getränkepauschale Longdrinks", "body_two" => body_two, "title_three" => "Sie haben die Wahl ...", "body_three" => body_three}
  getraenke.page = feierlichkeiten
  getraenke.save!
  getraenke.publish!

  hochzeit_one = Contentr::FourBlocksParagraph.new()
  hochzeit_one.area_name = "body"
  hochzeit_one.position = 9
  title_one = "Vorspeise serviert ..."
  body_one ="Tranchen von der Barbarie Flugentenbrust<br/>mariniert mit Sauce Cumberland<br/>auf gebuttertem Schwarzbrot & frittiertem Rucola"
  title_two = "Suppe serviert .."
  body_two = "Hochzeitssuppe mit Klöschen, Eierstich, Gemüsejuliennese & Petersilie"
  title_three = "Warmes vom Buffet ..."
  body_three = "Wildschweinbraten mit Soß, Preiselbeeren & gebratenen Waldpilzen<br/>Tranchen von der Maispoulardenbrust<br/>auf Zucchinirahmgemüse<br/>Medallion vom Schweinefilet<br/>mit Pariser Pfefferrahm & gegrillter Tomate<br/>Gebratenes Lachsfilet mit Zitronenpfeffer, Butter & Dill<br/>Blumenkohl mit Bröselbutter<br/>umringt von allerlei Gartengemüse<br/>Bohnen im Speckmantel<br/>Bandnudeln mit Kräutern<br/>Kartoffelgratin, Rosmarinkartoffeln & Herzoginkartoffeln<br/>"
  title_four = "Süßes vom Buffet..."
  body_four = "Vanilleeis mit warmenbeschwipsten Pflaumen<br/>Cremevariation im Glas<br/>Käseauswahl mit Obst"
  price = "pro Person ab 28,50"
  hochzeit_one.data = {"link_title" => "Hochzeit *", "title_one" => 'Kaffee & Kuchen ...', "body_one" => body_one, "title_two" => "Mitternachtssnack ...", "body_two" => body_two}
  hochzeit_one.page = feierlichkeiten
  hochzeit_one.save!
  hochzeit_one.publish!

  hochzeit_two = Contentr::FourBlocksParagraph.new()
  hochzeit_two.area_name = "body"
  hochzeit_two.position = 10
  body_one = "<p>Antipasti vom Gemüse<br/>Gebratene Zucchini, eingelegte Paprika, gegrillte Auberginen, gefüllte Champignons,<br/>Oliven in Kräutermarinade, gebratene Karotten mit Minze,<br/>gegrillte Cherrystrauch-Tomaten mit Mozzarellabällchen & Basilikum<br/>Eismeer-Shrimps mit Cocktailsauce<br/>Tranchen von der Hähnchenbrust mit Curryschmand & Früchten<br/>Schinkenvariationen mit Honigmelone<br/></p><p>Jahreszeitliche Blattsalate mit Tomate, Gurke, Zwiebel, Karotte & Kräuter<br/>Dressings & Essig/Öl<br/>Steinofenbrot & Baguette</p>"
  body_two = "<p>Frisch am Buffet tranchiert<br/>Barbarie Flugentenbrust rosa gebraten mit Orangenjus</p><p>Kalbsbraten aus dem Steinbackofen mit Riesling-Salbeisoße<br/>Rinderschmorsteaks mit gegrilltem Gemüse & Kräuter<br/>Lachsforellenfilet gebraten mit buntem Pfeffer & Zitrone</p><p>Jahreszeitliches Gemüse mit Sauce hollandaise<br/>Kleine Kartoffelklöße, Spätzle & Kartoffeldrillinge mit Kräuter,<br/>gebackene Kartoffel & Kroketten</p>"
  body_three ="<p>Pikante Cremesuppe vom Geflügel<br/>mit grünem Curry, Ingwer & Kokosmilch</p>"
  body_four = "<p>Vanille & Stracciatella Eismit heißen SchattenmorellenCremeduett im Glas</p>"
  price = "pro Person ab 26,50 €"
  hochzeit_two.data = {"link_title" => "Hochzeit **", "title_one" => 'Kaltes ...', "body_one" => body_one, "title_two" => "Warmes ..." , "body_two" => body_two, "title_three" => "Suppentopf ...", "body_three" => body_three, "title_four" => "Süßes ...", "body_four" => body_four}
  hochzeit_two.page = feierlichkeiten
  hochzeit_two.save!
  hochzeit_two.publish!

  hochzeit_three = Contentr::FourBlocksParagraph.new()
  hochzeit_three.area_name = "body"
  hochzeit_three.position = 11
  body_one = "<p>Vitello tonnato mit Kirschkapern<br/>Carpaccio vom Rinderfilet mit Parmesan & Rucola<br/>Coppa di Parma mit Cantaloupe Melone<br/>Tintenfischringe pikant gebraten mit Tomate & Olive<br/>Frischer Lachs hauchdünn mariniert mit Limetten Öl<br/>Entenbrust rosa gebraten an Pastetchen mit Cumberland Sahne<br/>Gebratene Garnelen auf Seealgensalat mit Sesam und Chili<br/>Baguettevariationen aus dem Steinbackofen</p>"
  body_two = "<p>Frisch am Buffet tranchiert<br/>Roastbeef rosa gebraten im Wildkräutermantel<br/>mit Pfefferbutter, Bohnenbündchen & Knoblauch Kartoffeln</p><p>Lammcarree aus dem Steinbackofen<br/>mit Rosmarin-Knoblauch Jus<br/>Kartoffelplätzchen mit Blattspinat & ziegenkäse überbacken</p><p>Schweinefilet Calvados<br/>mit Calvadossauce, sautierten Kirschäpfeln<br/>Mandelbällchen & jahreszeitlichen Blattsalaten mit Himbeerdressing</p><p>Medaillons vom Seeteufel auf grünem Spargel,<br/>Limettensauce gebutterten Bandnudeln</p>"
  body_three = "<p>Klare Oxtail mit Sherry & Champignonblätter-Chesterstange</p>"
  body_four = "<p>Eisvariationen mit Amarenakirschen, Eierlikör & sahneDampfnudeln mit Vanillesoße & MohnzuckerErdbeeren mit grünem Pfeffer & Schneezucker</p>"
  price = "pro Person ab 33,50 €"
  hochzeit_three.data = {"link_title" => "Hochzeit ***", "title_one" => 'Kaltes ...', "body_one" => body_one, "title_two" => "Warmes ..." , "body_two" => body_two, "title_three" => "Suppentopf ...", "body_three" => body_three, "title_four" => "Süßes ...", "body_four" => body_four}
  hochzeit_three.page = feierlichkeiten
  hochzeit_three.save!
  hochzeit_three.publish!

  herbst = Contentr::FourBlocksParagraph.new()
  herbst.area_name = "body"
  herbst.position = 12
  body_one = "<p>Winterliche Blattsalate mit gebratenem Speck, Croutons & Himbeerdressing</p>"
  body_two = "<p>Ein ganzer Truthahn frisch aus dem Backofen und am Buffet tranchiert mit Soße & Bratapfel</p><p>Wildbraten aus heimischen Wäldern<br/>mit Wacholderrahm, Preiselbeerbirne & gebratenen Pilze</p><p>Geschmorte Rinderrouladen in Jus<br/>mit Speck & Gürkchen gefüllt</p>"
  body_three = "<p>Gebratenes Seelachsfilet auf süß saurem Kartoffel-Birnen-Salat</p><p>Apfelrotkohl, Speckrosenkohl & Marktgemüse<br/>Kartoffelklöße, Kroketten & Petersilienkartoffeln</p>"
  body_four = "Apfel-Crumble mit Zimtsahne & Vanilleeis"
  price = "pro Person ab 25,50 €"
  herbst.data = {"link_title" => "Herbst & Winter", "title_one" => 'Vorspeise serviert ...', "body_one" => body_one, "title_two" => "Warmes ..." , "body_two" => body_two, "title_three" => "Suppentopf ...", "body_three" => body_three, "title_four" => "Süßes ...", "body_four" => body_four}
  herbst.page = feierlichkeiten
  herbst.save!
  herbst.publish!

  rustikal = Contentr::ThreeBlocksParagraph.new()
  rustikal.area_name = "body"
  rustikal.position = 13
  body_one = "<p>Matjesfilet natur mit Zwiebeln & Kräutern,<br/>eingelegte Sülze in Kräutermarinade, saurer Gurke & Remoulade<br/>Schinkenbrett, Harzer Mettwurst & Mixed Pickles<p/><p>Zweierlei Krautsalat<br/>Käsebrett & Harzer Roller<p/><p>Hausgebackenes Steinofenbrot<br/>Butter & Schmalz<p/>"
  body_two = "<p>Hausgespritzter Krustenbraten aus dem Steinbackofen<br/>mit Aprikosen Senf<br/>Putenoberkeule gebacken auf Pfannengemüse & Jus<br/>Schweinenackenbrate mit gebratenen Zwiebeln & Bratensoße<p/>"
  body_three = "<p>Kartoffelsuppe mit Schmand & Rauchfleischstreifen<p/><p>Süßes ...<p/><p>EisvariationenRote Grütze mit Vanillesoße<p/>"
  price = "pro Person ab 18,50 €"
  rustikal.data = {"link_title" => "Rustikal", "title_one" => 'Kaltes ...', "body_one" => body_one, "title_two" => "Warmes ..." , "body_two" => body_two, "title_three" => "Suppentopf ...", "body_three" => body_three}
  rustikal.page = feierlichkeiten
  rustikal.save!
  rustikal.publish!

  achtziger = Contentr::FourBlocksParagraph.new()
  achtziger.area_name = "body"
  achtziger.position = 14
  body_one = "<p>Jahreszeitliche Blattsalate, Rote Beete Salat,<br/>Karottensalat mit Orange, Weißkrautsalat, Bohnensalat,<br/>Gurkensalat mit Dill, Tomatensalat mit Zwiebel & Kräuter<br/>Dressings, Essig/Öl</p>"
  body_two = "<p>Französische Zwiebelsuppe<br/>mit Croutons</p>"
  body_three = "<p>Pfefferfleisch<br/>Schweinefleischwürfel kurz gebraten mit Zwiebeln,<br/>geschrotetem Pfeffer & Knoblauch</p><p>Heberbörder Fleischspieß<br/>mit Schweinerückensteak, Hähnchenbrust & Grilltomaten</p><p>Chinatopf<br/>Currygeschnetzeltes vom Geflügel mit Ananas & Pfirsich</p><p>Buntes Marktgemüse<br/>mit Sauce hollandaise & Butter</p><p>Kartoffelbällchen, Röstitaler, Butterreis<br/>Bratkartoffeln mit Speck & Zwiebeln</p>"
  body_four = "<p>Vanilleeis mit heißen Kirschen,<br/>Eierlikör & Schlagsahne</p>"
  price = "pro Person ab 17,50 €"
  achtziger.data = {"link_title" => "Achtziger", "title_one" => 'Salatbuffet ...', "body_one" => body_one, "title_two" => "Suppentopf ..." , "body_two" => body_two, "title_three" => "Warmes ...", "body_three" => body_three, "title_four" => "Süßes ...", "body_four" => body_four}
  achtziger.page = feierlichkeiten
  achtziger.save!
  achtziger.publish!

  sliderfeierlichkeiten = Contentr::EventGalleryParagraph.new()
  sliderfeierlichkeiten.area_name = "body"
  sliderfeierlichkeiten.position = 15
  sliderfeierlichkeiten.data = {"link_title" => "Aktuelles"}
  sliderfeierlichkeiten.page = feierlichkeiten
  sliderfeierlichkeiten.save!
  sliderfeierlichkeiten.publish!

  # ALLGEMEINES

  allgemeines = Contentr::LinkedPage.new()
  allgemeines.name = "Allgemeines"
  allgemeines.slug = "catering/allgemeines".parameterize
  allgemeines.menu_only = nil
  allgemeines.type = "Contentr::LinkedPage"
  allgemeines.ancestry = nil
  allgemeines.description = nil
  allgemeines.menu_title = "Allgemeines"
  allgemeines.published = true
  allgemeines.hidden = false
  allgemeines.layout = "frontend_app"
  allgemeines.template = "default"
  allgemeines.linked_to = "frontend/catering/pages#allgemeines"
  allgemeines.save!

  # GEMEINSCHAFTSPFLEGE

  gemeinschaftspflege = Contentr::LinkedPage.new()
  gemeinschaftspflege.name = "Gemeinschaftspflege"
  gemeinschaftspflege.slug = "catering/gemeinschaftspflege".parameterize
  gemeinschaftspflege.menu_only = nil
  gemeinschaftspflege.type = "Contentr::LinkedPage"
  gemeinschaftspflege.ancestry = nil
  gemeinschaftspflege.description = nil
  gemeinschaftspflege.menu_title = "Gemeinschaftspflege"
  gemeinschaftspflege.published = true
  gemeinschaftspflege.hidden = false
  gemeinschaftspflege.layout = "frontend_app"
  gemeinschaftspflege.template = "default"
  gemeinschaftspflege.linked_to = "frontend/catering/pages#gemeinschaftspflege"
  gemeinschaftspflege.save!

  # BILDER

  bilder = Contentr::LinkedPage.new()
  bilder.name = "Bilder"
  bilder.slug = "catering/bilder".parameterize
  bilder.menu_only = nil
  bilder.type = "Contentr::LinkedPage"
  bilder.ancestry = nil
  bilder.description = nil
  bilder.menu_title = "Bilder"
  bilder.published = true
  bilder.hidden = false
  bilder.layout = "frontend_app"
  bilder.template = "default"
  bilder.linked_to = "frontend/catering/pages#bilder"
  bilder.save!

  # GLOBAL MENU

  menu = Contentr::HtmlParagraph.new()
  menu.area_name = "nav"
  menu.position = 1
  body = "<li><a href='/home'><i class='fa fa-home'></i>&nbsp;&nbsp;Startseite</a></li><li><a class='dropdown-toogle' data-open='false' id='landgasthaus'><i class='fa fa-chevron-down'></i>&nbsp;&nbsp;Landgasthaus</a><ul type='none' class='dropdown' id='landgasthaus'><li><a href='/landgasthaus/hotel'>Hotel</a></li><li><a href='/landgasthaus/erholungundkultur'>Erholung & Kultur</a></li><li><a href='/landgasthaus/feierlichkeiten'>Feierlichkeiten</a></li><li><a href='/anfahrt'>Anfahrt</a></li></ul></li><li><a class='dropdown-toogle' data-open='false' id='catering'><i class='fa fa-chevron-down'></i>&nbsp;&nbsp;Catering</a><ul type='none' class='dropdown' id='catering'><li><a href='/catering/allgemeines'>Allgemeines</a></li><li><a href='/catering/gemeinschaftspflege'>Gemeinschaftspflege</a></li><li><a href='/catering/bilder'>Bilder</a></li></ul><li><a href='/kontakt'>Kontakt</a></li></li><li><a href='/impressum'>Impressum</a></li>"
  menu.data = {"body" => body}
  menu.page = cms
  menu.save!
  menu.publish!
end
