class EventTabulatrData < Tabulatr::Data
  search :title
  column :id
  column :title
  column :type
  column :image do |rec|
    if rec.image.present?
      image_tag rec.image.thumb
    else
      'foo'
    end
  end
  column :actions do |rec|
    actions = [
      "#{link_to(icon('edit'), edit_backend_landgasthaus_event_path(rec))}",
      "#{link_to(icon('trash-o'), backend_landgasthaus_event_path(rec), method: 'delete', confirm: 'sure?', style: 'margin-left:10px')}"
    ]
    actions.join('')
  end
end

