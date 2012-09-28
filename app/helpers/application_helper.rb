module ApplicationHelper
  include ActsAsTaggableOn::TagsHelper

  def prepare_form_params(obj)
    {
        url: "/#{obj.class.name.pluralize.downcase}/#{obj.id.to_s}",
        html: {method: obj.id.blank? ? :post : :put, :class => "#{obj.class.name.downcase}_form"}
    }
  end
end
