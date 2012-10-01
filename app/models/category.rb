class Category < ActiveRecord::Base
  attr_accessible :avatar, :name
  has_many :topics, :dependent => :destroy

  validates :name, :presence => true, :length => { :within => 1..512 }, :uniqueness => true
  before_save :prepare_avatar

  def self.init_rails_cache
    Category.includes(:topics).all.each_with_object({}) do |cat, ret|
      ret.update(cat.id => [])
      cat.topics.each { |topic| ret[cat.id] << topic.as_option }
    end
  end

  def self.cached_topics(category_id)
    (Rails.cache.read(:categories_tree) || init_rails_cache)[category_id]
  end

protected
  def prepare_avatar
    self.avatar ||= "/assets/category_default_small.png"
  end
end
