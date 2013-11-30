class Backend::Landgasthaus::PageElementsController < Backend::Landgasthaus::ApplicationController

  MODEL_MAP = {
    cell: Cell,
    row: Row,
    image: Image,
    gallery_slider: GallerySlider,
    vertical_grid: VerticalGrid,
    horizontal_grid: HorizontalGrid,
    headline: Headline,
    textbox: Textbox,
  }

  before_filter :globalize_content

  def create
    # raise page_element_params.inspect
    element = @klaz.new(page_element_params)
    element.page = @page
    send_json do
      element.save && {type: params[:page_element][:type], ele_info: element}
    end
  end

  def load_form
    element = @klaz.find(params[:page_element][:id])
    # render json: {form: render_to_string(partial: "backend/partials/forms/#{params[:page_element][:type]}_form", locals: {element: element.becomes(PageElement), page: @page})}
    render json: {form: render_to_string(partial: "backend/partials/forms/#{element.type.downcase}_form", locals: {element: element.becomes(PageElement), page: @page})}
  end

  def update
    @element = @klaz.find(params[:page_element][:id])
    if page_element_params[:gallery_id]
      gallery = Gallery.find(page_element_params[:gallery_id])
      @element.images = "#{gallery.gallery_images.map(&:image).join(', ')}"
    end
    @element.update_attributes(page_element_params)
    send_json do
      @element.save && {type: params[:page_element][:type], ele_info: @element}
    end
  end

  def destroy
    element = @klaz.find(params[:id])
    send_json do
      element.destroy && {type: params[:page_element][:type], id: element.internal_id}
    end
  end

  def upload
    file = request.env['action_dispatch.request.request_parameters']["image"]
    element = @klaz.find(params[:id])
    element.image = file
    send_json do
      element.save && {success: true, type: params[:type], element: element}
    end
  end

  def edit
  end

private

  def page_element_params
    params.require(:page_element).permit(*PageElement.permitted_attributes)
  end

  def send_json(&block)
    s = yield
    if s
      respond_to do |format|
        format.json do
          render json: s
        end
      end
    else
      raise '500'
    end
  end

  def globalize_content
    @page = Page.find(params[:page_id])
    @klaz = MODEL_MAP[params[:page_element][:type].to_sym]
    raise "No class found for '#{params[:page_element][:type]}'" unless @klaz
  end

end
