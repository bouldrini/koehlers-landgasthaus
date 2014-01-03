class DatepickerInput < SimpleForm::Inputs::Base
  def input
    input_html_options[:data] = {provide: 'datepicker', :"date-format" => 'dd.mm.yyyy'}
    @builder.text_field(attribute_name, input_html_options)
  end
end
