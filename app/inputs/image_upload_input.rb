# coding: utf-8

class ImageUploadInput < SimpleForm::Inputs::FileInput

  def input
    s            = []
    thumb        = options.delete(:thumb)
    delete_label = options.delete(:delete_label) || 'Löschen?'
    if @builder.object.send("#{attribute_name}").present?
      if thumb != false
        s << (template.content_tag :div do
            @builder.object = @builder.object.becomes @builder.object.type.constantize
                template.image_tag @builder.object.send("#{attribute_name}_url", thumb), class: 'image-uload-input-thumb'
              end)
      end
      s << (template.label_tag(nil, :class => "checkbox") do
              @builder.check_box("remove_#{attribute_name}") + delete_label
            end)
    end
    s << super
    s.join("\n").html_safe
  end

end
