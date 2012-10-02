module CategoriesHelper
  include ActionView::Helpers::UrlHelper
  include ActionView::Helpers::TextHelper

  def prepare_list(topics)
    topics.map do |topic|
      "<li class='content_block #{cycle("wbg", "abg", "bbg")}'>
      <span>#{link_to "#{topic.name}", Rails.application.routes.url_helpers.topic_path(topic)}</span>
      <span class='fr'>#{pluralize(topic.posts_count, 'post')}</span>
      <span class='cb'>
      </li>"
    end
  end
end
