class Post < ActiveRecord::Base
  include Previewer
  require "syntaxer"

  acts_as_taggable_on :tags
  attr_accessible :name, :body

  belongs_to :topic, :counter_cache => true

  default_scope where(:trash => false).order("created_at DESC")
  scope :trash, unscoped.where(:trash => true)

  before_save :prepare_preview

  validates :name, :presence => true, :length => { :within => 1..512 }, :uniqueness => { :case_sensitive => false }
  validates :body, :presence => true

  def pretty_body
    Post.prepare_content(self.body)
  end

  def pretty_preview
    Post.prepare_content(get_preview)
  end

  def self.prepare_content(val)
    Syntaxer.prepare_html(val.dup)
  end

  def has_preview?
    preview.present?
  end

  def get_preview
    preview || body
  end
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
    ActsAsTaggableOn::Tag.all.sort.map(&:name)
  end

  def self.cloud_as_relation
    ActsAsTaggableOn::Tagging.joins(:tag).select("tags.name as name, tag_id as id").group(["tag_id", "tags.name"]).count
  end

  def self.cloud_as_js
    return "" if (temp = self.cloud_as_relation).empty?
    max = temp.first.last.to_f
    temp.map {|k, v| "{id:'#{k.last}',text:'#{k.last}',weight:'#{v/max}'}"}.join(',')
  end
end
