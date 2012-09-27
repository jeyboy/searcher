module CategoriesHelper
  include ActionView::Helpers::UrlHelper
  include ActionView::Helpers::TextHelper

  def prepare_list(topics)
    topics.map { |topic| "<li class='container'>#{link_to "#{topic.name} (#{pluralize(topic.posts_count, 'post')})", Rails.application.routes.url_helpers.topic_path(topic)}</li>" }
  end
end
