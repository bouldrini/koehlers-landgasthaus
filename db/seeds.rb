s = Statistic.new
s.count_requests = 0
s.save

u = User.new(email: 'admin@lghk-web.de', password: 'lghk-web', password_confirmation: 'lghk-web')
u.save

event = Event.new
event.title = "Großes Fischbuffet"
event.subtitle = "Von A wie Aal, J wie Jacobsmuschel, S wie Seeteufel bis Z wie Zander – alles Rund um Meer und Fluß!"
event.start_at = Time.zone.parse("2014-03-01 00:00:00 UTC")
event.body = "<p><p>Ab 18:00 Uhr Ein Muss für jeden Fischliebhaber!</p>"
event.end_at = Time.zone.parse("2014-03-01 00:00:00")
event.save

event = Event.new
event.title = "Deutscher Spargel!"
event.subtitle = "Frisch vom Bauern aus Gilten in der Heide… seit über 30 Jahren!"
event.start_at = Time.zone.parse("2014-05-01 00:00:00 UTC")
event.body = "Kommen alle Spargelfreunde voll auf Ihre Kosten!</p><p>Auf unserem „Schlemmen unter’m Schindeldach“-Buffet gibt es Zusätzlich frischen Heidespargel mit Sauce hollandaise & Butter,Schnitzel, Schinken, Lachs & einfach allem was dazu gehört!… so viel Sie mögen!</p><p>Pro Person Satt 11,50 € inkl. 1 Obstler</p>"
event.end_at = Time.zone.parse("2014-06-15 00:00:00")
event.save

event = Event.new
event.title = "Ostern"
event.subtitle = "Frühlingshaftes Osterbuffet"
event.start_at = Time.zone.parse("2014-04-20 00:00:00 UTC")
event.body = "<p>Schmackhaftes vom Lamm, Kaninchen, Zander und vieles Mehr ...</p>"
event.end_at = Time.zone.parse("2014-04-21 00:00:00")
event.save

event = Event.new
event.title = "Ein Duett der besonderen Art"
event.subtitle = "Matjes & Pfifferlinge"
event.start_at = Time.zone.parse("2014-06-28 00:00:00 UTC")
event.end_at = Time.zone.parse("2014-06-29 00:00:00")
event.save

event = Event.new
event.title = "Winter ist Grünkohlzeit!"
event.subtitle = "Während der Wintermonate haben wir auf unserem Buffet immer eine Ecke mit dem Klassiker Grünkohl und Bregenwurst vorgesehen."
event.start_at = Time.zone.parse("2014-01-01 00:00:00 UTC")
event.body = "<p>Für Gruppen & Grünkohlwanderungen bieten wir an:</p><p>Grünkohl mit Kasseler, Kasseler Bauch, Zweierlei Bregenwurst, Bratkartoffeln & Senf</p><p>Pro Person Satt 11,50 € inkl. 1 Obstler</p>"
event.end_at = Time.zone.parse("2014-02-01 00:00:00")
event.save

event = Event.new
event.title = "Ein kleiner Vorgeschmack auf Ihren Sommer-Urlaub!"
event.subtitle = "… Italien, Spanien, Kroatien & Griechenland.<br/>Genießen Sie unsere lukullische Mittelmeerkreuzfahrt an unserem mediterranem Buffet!"
event.start_at = Time.zone.parse("2014-07-12 00:00:00 UTC")
event.end_at = Time.zone.parse("2014-07-13 00:00:00")
event.save

event = Event.new
event.title = "Sommerzeit ist Steak & Salat Zeit !"
event.subtitle = "Samstags ab 18:00 Uhr<br/>Sonntags von 11:30 bis 14:00 Uhr"
event.start_at = Time.zone.parse("2014-08-02 00:00:00 UTC")
event.body = "<p>Unser „Schlemmen unter’m Schindeldach“-Buffet mit Steaks vom Rind,Schwein & Geflügel, gebratener Fisch, Saucen & Dipps, pfiffiges von der Knolleund leckeres aus dem Gemüsegarten, buntes Salatbuffet & erfrischendes aus der süßen Ecke.</p>"
event.end_at = Time.zone.parse("2014-08-31 00:00:00")
event.save

event = Event.new
event.title = "Oktober & November"
event.subtitle = "Leckeres aus dem Steinbackofen!"
event.start_at = Time.zone.parse("2014-10-01 00:00:00 UTC")
event.body = "<p>Saftige Schweinehaxen, hausgespritzter Krustenbraten, Wild aus heimischen Wäldern, Spanferkel, Keulen, knusprige Gans gepaart mit bodenständigen Beilagen  & leckeren Waldpilzen</p><p>Samstags ab 18:00 Uhr<br/>Sonntags 11:30 bis 14:00 Uhr</p>"
event.end_at = Time.zone.parse("2014-11-31 00:00:00")
event.save

event = Event.new
event.title = "Steinpilze!"
event.subtitle = "Der König der Pilze"
event.start_at = Time.zone.parse("2014-10-03 00:00:00 UTC")
event.body = "<p>Für alle Pilz-Feinschmecker</p><p>Samstag ab 18:00 Uhr<br/>Sonntag & Feiertag 11:30 bis 14:00 Uhr<br/>… einfach Genießen, wenn der Pilzsammler kommt!</p>"
event.end_at = Time.zone.parse("2014-10-05 00:00:00")
event.save

event = Event.new
event.title = "Fröhliche Weihnachten!"
event.subtitle = "Traditionell & landhaustypisch"
event.start_at = Time.zone.parse("2014-12-25 00:00:00 UTC")
event.body = "<p>Der kulinarische Weihnachtsklassiker für die ganze Familie!</p><p>Von 11:30 bis 14:00 Uhr<br/>… jetzt schon Reservieren!</p>"
event.end_at = Time.zone.parse("2014-12-26 00:00:00")
event.save

Event.all.each do |event|
  event.area = 'landgasthaus'
  event.save
end
