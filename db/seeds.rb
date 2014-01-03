u = User.new(email: 'admin@lghk-web.de', password: 'lghk-web', password_confirmation: 'lghk-web')
u.save

3.times do |i|
  e = Collage.create(title: "Event-#{i}", area: 'landgasthaus', subtitle: "Event-Subtitle-#{i}", active: true, start_at: Date.today, end_at: (Date.today + 4.hours))
end
