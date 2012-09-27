class CategoryObserver < ActiveRecord::Observer
  def after_create(category)
    val = Rails.cache.read(:categories_tree) || Category.init_rails_cache
    val.update(category.id => [])
    Rails.cache.write(:categories_tree, val)
  end

  def after_destroy(category)
    val = Rails.cache.read(:categories_tree) || Category.init_rails_cache
    val.delete(category.id)
    Rails.cache.write(:categories_tree, val)
  end
end
