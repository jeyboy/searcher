require 'previewer'
require 'syntaxer'

class Post < ActiveRecord::Base
  include ::Previewer

  belongs_to :category
  has_many :taggables, as: :tagged
  has_many :tags, through: :taggables

  validates :name, :body, presence: true

  before_validation :unescape, on: :create

  private

  def unescape
    self.body = ::Syntaxer.prepare_html(CGI.unescape(body))
  end
end
