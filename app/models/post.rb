require 'previewer'
require 'syntaxer'
require 'cleaner'

# todo: update not work
class Post < ActiveRecord::Base
  include ::Previewer

  has_paper_trail

  belongs_to :category
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :taggables, as: :tagged
  has_many :tags, through: :taggables

  validates :name, :body, :category_id, presence: true

  before_validation :unescape

  def preview
    super.gsub(/<img[^>]*>/, '')
  end

  private

  def unescape
    self.body = CGI.unescape(body)
    self.body = ::Cleaner.prepare_body(::Syntaxer.prepare_html(body)) unless self.id
  end
end
