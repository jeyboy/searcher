class Post < ActiveRecord::Base
  include Previewer
  require "syntaxer"

  acts_as_taggable_on :tags
  attr_accessible :name, :body

  belongs_to :topic, :counter_cache => true

  default_scope order("created_at DESC")

  before_save :prepare_preview

  def body
    Syntaxer.prepare_html(super)
  end

  def preview
    super || preview_by_length
  end

protected
  def preview_by_length
    self.preview_count > 0 ? self.body[0..self.preview_count] : body
  end

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
