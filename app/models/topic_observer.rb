class TopicObserver < ActiveRecord::Observer
  def after_create(topic)
    val = Rails.cache.read(:categories_tree) || Category.init_rails_cache
    val[topic.category_id] << topic.as_option
    Rails.cache.write(:categories_tree, val)
  end

  def after_destroy(topic)
    val = Rails.cache.read(:categories_tree) || Category.init_rails_cache
    val[topic.category.id].delete([topic.name, topic.id])
    Rails.cache.write(:categories_tree, val)
  end
end
