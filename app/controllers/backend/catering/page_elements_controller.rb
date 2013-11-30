class Backend::Catering::PageElementsController < Backend::Catering::ApplicationController
  MODEL_MAP = {
    image: Image,
    spacing: Spacing,
    headline: Headline,
    textbox: Textbox,
  }

  before_filter :globalize_content

  def create
    element = @klaz.new(page_element_params)
    element.page = @page
    send_json do
      element.save && element
    end
  end

  def update
    element = @klaz.find(params[:id])
    element.update_attributes(page_element_params)
    send_json do
      element.save && {type: params[:type], ele_info: element}
    end
  end

  def destroy
    element = @klaz.find(params[:id])
    send_json do
      element.destroy && {type: params[:type], id: element.id}
    end
  end

  def upload
    file = request.env['action_dispatch.request.request_parameters']["passelement"]
    element = @klaz.find(params[:id])
    element.backgroundpicture = file
    element.border_radius = nil
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
