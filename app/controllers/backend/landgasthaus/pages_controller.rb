# encoding: utf-8
class Backend::Landgasthaus::PagesController < Backend::Landgasthaus::ApplicationController
  def index
    tabulatr_for Page.landgasthaus
  end

  def new
    @page = Page.new
  end

  def edit
    @page = Page.find(params[:id])
    @namespace = ''
  end

  def update
    @page = Page.find(params[:id])
  end

  def create
    @page = Page.new(page_params)
    @page.landgasthaus = true
    @page.catering = false
    if @page.save
      internal_cell_id = 0
      5.times do |i|
        row = Row.new(height: 200, split: true,internal_id: i, page: @page)
        if row.save
          2.times do |n|
            element = Cell.new
            element.row = row
            element.side = n
            element.page = @page
            element.internal_id = internal_cell_id
            element.save
            internal_cell_id += 1
          end
        end
      end
      flash[:success] = "Seite erfolgreich angelegt"
      redirect_to backend_landgasthaus_pages_path
    else
      render :new
    end
  end

  def destroy
    Page.find(params[:id]).destroy
    redirect_to backend_landgasthaus_pages_path
  end

  private

  def page_params
    params.require(:page).permit(:title, :landgasthaus, :catering)
  end
end
