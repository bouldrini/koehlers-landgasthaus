module ApplicationHelper
  def icon(name)
    "<i class='fa fa-#{name}'></i>".html_safe
  end

  def nicedate(date)
    date.strftime('%d.%m.%Y')
  end
end
