class Backend::Catering::PagesController < Backend::Catering::ApplicationController
  def index
    tabulatr_for Page.catering
  end
  def new
    @page = Page.new
  end

  def edit
    @page = Page.find(params[:id])
  end

  def create
    @page = Page.new(page_params)
    @page.catering = true
    @page.landgasthaus = false
    if @page.save
      (@page.height / (@page.height / 5)).to_i.times do |i|
        element = Cell.new
        element.height = @page.height / 5
        element.page = @page
        element.save
      end
      flash[:success] = "Seite erfolgreich angelegt"
      redirect_to backend_catering_pages_path
    else
      render :new
    end
  end

  def destroy
    Page.find(params[:id]).destroy
    redirect_to backend_catering_pages_path
  end

  private

  def page_params
    params.require(:page).permit(:title, :landgasthaus, :catering)
  end
end