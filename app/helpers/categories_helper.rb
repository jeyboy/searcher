module CategoriesHelper
  include ActionView::Helpers::UrlHelper

  def prepare_list(topics)
    topics.map { |topic| "<li>#{link_to topic.name, Rails.application.routes.url_helpers.topic_path(topic)}</li>" }
  end
end
