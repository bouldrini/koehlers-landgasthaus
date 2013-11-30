class Backend::Landgasthaus::GalleryMappingsController < Backend::ApplicationController
	def destroy
		mapping = GalleryMapping.find(params[:id])
		if mapping.destroy
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