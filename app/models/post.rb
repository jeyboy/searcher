class Post < ActiveRecord::Base
  include Previewer

  acts_as_taggable_on :tags
  attr_accessible :name, :body

  belongs_to :topic, :counter_cache => true

  default_scope order("created_at DESC")

  before_save :prepare_preview

protected
  def self.by_all_tags(tags)
    self.tagged_with(tags, :match_all => true)
  end

  def self.by_one_of_the_tags(tags)
    self.tagged_with(tags, :any => true)
  end

  def self.by_partial_of_one_of_the_tags(tags)
    self.tagged_with(tags, :any => true, :wild => true)
  end

  def self.all_tags()
    ActsAsTaggableOn::Tag.all.map(&:name)
  end
end
