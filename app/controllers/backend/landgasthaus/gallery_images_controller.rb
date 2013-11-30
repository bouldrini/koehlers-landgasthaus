class Backend::Landgasthaus::GalleryImagesController < Backend::ApplicationController
	def destroy
		image = GalleryImage.find(params[:id])
		gallery = image.gallery
		if image.destroy
			gallery.gallery_sliders.each do |slider|
				slider.images = gallery.gallery_images.map(&:image).join(', ')
				slider.save
			end
			respond_to do |format|
		    format.json do
		        render json: {success: true}
		    end
		    format.html
	    end
		else
			raise 'error'
		end
	end
end
