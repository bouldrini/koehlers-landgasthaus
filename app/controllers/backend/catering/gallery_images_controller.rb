class Backend::Catering::GalleryImagesController < Backend::ApplicationController
	def destroy
		image = GalleryImage.find(params[:id])
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