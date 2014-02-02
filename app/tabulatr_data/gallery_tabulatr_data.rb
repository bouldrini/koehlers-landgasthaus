class GalleryTabulatrData < Tabulatr::Data
  search :title
  column :id
  column :title
  column :images do |rec|
    "#{rec.gallery_images.count}"
  end
  column :actions do |rec|
    actions = [
      "#{link_to(icon('edit'), edit_backend_landgasthaus_gallery_path(rec))}",
      "#{link_to(icon('trash-o'), backend_landgasthaus_gallery_path(rec), method: 'delete', confirm: 'sure?', style: 'margin-left:10px')}"
    ]
    actions.join('')
  end
end

