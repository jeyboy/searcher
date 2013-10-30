require 'previewer'
require 'syntaxer'

# todo: update not work
class Post < ActiveRecord::Base
  include ::Previewer

  belongs_to :category
  has_many :taggables, as: :tagged
  has_many :tags, through: :taggables

  validates :name, :body, presence: true

  before_validation :unescape

  def preview
    super.gsub(/<img[^>]*>/, '')
  end

  private

  def unescape
    self.body = CGI.unescape(body)
    self.body = ::Syntaxer.prepare_html(body) unless self.id
  end
end
