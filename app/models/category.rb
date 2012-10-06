class Category < ActiveRecord::Base
  attr_accessible :avatar, :name
  has_attached_file :avatar,
                    :styles => { :medium => "80x80>", :thumb => "40x40>" },
                    :default_url => '/assets/category_default_:style.png',
                    :default_style => :medium

  has_many :topics, :dependent => :destroy

  validates :name, :presence => true, :length => { :within => 1..512 }, :uniqueness => { :case_sensitive => false }

  def self.init_rails_cache
    Category.includes(:topics).all.each_with_object({}) do |cat, ret|
      ret.update(cat.id => [])
      cat.topics.each { |topic| ret[cat.id] << topic.as_option }
    end
  end

  def self.cached_topics(category_id)
    (Rails.cache.read(:categories_tree) || init_rails_cache)[category_id]
  end
end
