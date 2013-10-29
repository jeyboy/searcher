require 'previewer'

class Post < ActiveRecord::Base
  include ::Previewer

  belongs_to :category
  has_many :taggables, as: :tagged
  has_many :tags, through: :taggables

  validates :name, :body, presence: true

  before_validation :unescape

  def prepare_content(val)
    Syntaxer.prepare_html(val.dup)
  end

  def pretty_body
    prepare_content(body)
  end

  def pretty_preview
    prepare_content(preview)
  end

  private

  def unescape
    self.body = CGI.unescape(body)
  end
end
