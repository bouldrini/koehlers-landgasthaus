module LandgasthausKoehler::PermittedAttributes
  def permitted_attributes(*atts)
    if atts.present?
      @permitted_attributes ||= []
      @permitted_attributes = [@permitted_attributes, atts].flatten if atts.length > 0
      @permitted_attributes
    else
      pa = if superclass < ActiveRecord::Base
        superclass.permitted_attributes
      else
        []
      end
      [@permitted_attributes, pa].flatten.compact
    end
  end
end

ActiveRecord::Base.send :extend, LandgasthausKoehler::PermittedAttributes
