s = Statistic.new
s.count_requests = 0
s.save

u = User.new(email: 'admin@lghk-web.de', password: 'lghk-web', password_confirmation: 'lghk-web')
u.save

3.times do |i|
  e = Collage.create(title: "Event-#{i}", area: 'landgasthaus', subtitle: "Event-Subtitle-#{i}", active: true, start_at: Date.today, end_at: (Date.today + 4.hours))
end

event = Event.new
event.title = "Großes Fischbuffet"
event.subtitle = "Von A wie Aal bis Z wie Zander!"
event.start_at = Time.zone.parse("2014-03-01 00:00:00 UTC")
event.end_at = Time.zone.parse("2014-03-01 00:00:00")
event.save

event = Event.new
event.title = "Deutscher Spargel!"
event.subtitle = "Aus Gilten in der Heide!"
event.start_at = Time.zone.parse("2014-05-01 00:00:00 UTC")
event.end_at = Time.zone.parse("2014-06-15 00:00:00")
event.save

event = Event.new
event.title = "Ostern"
event.subtitle = "Frühlingshaftes Osterbuffet"
event.start_at = Time.zone.parse("2014-04-20 00:00:00 UTC")
event.end_at = Time.zone.parse("2014-04-21 00:00:00")
event.save

event = Event.new
event.title = "Matjes & Pfifferlinge"
event.subtitle = "Ein Duett der besonderen Art"
event.start_at = Time.zone.parse("2014-06-28 00:00:00 UTC")
event.end_at = Time.zone.parse("2014-06-29 00:00:00")
event.save

