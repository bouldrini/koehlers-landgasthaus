class Backend::Landgasthaus::GalleryImagesController < Backend::ApplicationController
	def destroy
		image = GalleryImage.find(params[:id])
		gallery = image.gallery
		if image.destroy
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
