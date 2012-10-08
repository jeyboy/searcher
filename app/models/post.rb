class Post < ActiveRecord::Base
  include Previewer
  require "syntaxer"

  acts_as_taggable_on :tags
  attr_accessible :name, :body

  belongs_to :topic, :counter_cache => true

  default_scope order("created_at DESC")

  before_save :prepare_preview

  def pretty_body
    Post.prepare_content(self.body)
  end

  def pretty_preview
    Post.prepare_content(preview)
  end

  def preview
    super || preview_by_length
  end


  def self.prepare_content(val)
    Syntaxer.prepare_html(val.dup)
  end
protected
  def preview_by_length
    self.preview_count.to_i > 0 ? self.body[0..self.preview_count] : body
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

  def self.cloud_as_relation
    ActsAsTaggableOn::Tagging.joins(:tag).select("tags.name as name, tag_id as id").group(["tag_id", "tags.name"]).count
  end

  def self.cloud_as_js
    return "" if (temp = self.cloud_as_relation).empty?
    max = temp.first.last.to_f
    temp.map {|k, v| "{id:'#{k.last}',text:'#{k.last}',weight:'#{v/max}'}"}.join(',')
  end
end
