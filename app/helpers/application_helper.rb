module ApplicationHelper
  include ActsAsTaggableOn::TagsHelper

  def prepare_form_params(obj)
    obj_name = obj.class.name.downcase
    {
        url: "/#{obj_name.pluralize}/#{obj.id.to_s}",
        html: {method: obj.persisted? ? :put : :post, :class => "#{obj_name}_form"}
    }
  end
end
