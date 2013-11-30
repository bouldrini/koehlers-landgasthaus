class Backend::Landgasthaus::GalleriesController < Backend::ApplicationController
  def edit
    @gallery = Gallery.find(params[:id])
    @per_row = (@gallery.gallery_images.count / 4)
    @mappings = @gallery.gallery_mappings.all
  end

  def new
    @gallery = Gallery.new
  end

  def index
    tabulatr_for Gallery.order('title asc')
  end

  def create
    images = gallery_params[:images] if gallery_params[:images]
    @gallery = Gallery.new(gallery_params)
    if @gallery.save
       if images.present?
          images.each do |img|
            GalleryImage.link(img, @gallery)
          end
      end
      redirect_to backend_landgasthaus_galleries_path
    else
    raise @gallery.save!
      render :new
    end
  end

  def update
    images = gallery_params[:images] if gallery_params[:images]
    @gallery = Gallery.find(params[:id])
    if @gallery.update_attributes(gallery_params)
      if images.present?
        images.each do |img|
          gal_img = GalleryImage.link(img, @gallery)
        end
        @gallery.gallery_sliders.each do |slider|
          slider.images = "#{@gallery.gallery_images.map(&:image).join(', ')}"
          slider.save
        end
      end
    redirect_to backend_landgasthaus_galleries_path
    else
      render :edit
    end
  end

  def destroy
    gallery = Gallery.find(params[:id])
    if gallery.destroy
      redirect_to backend_landgasthaus_galleries_path
    else
      raise 'error'
    end
  end

  private

  def gallery_params
    params.require(:gallery).permit(*Gallery.permitted_attributes)
  end
end
