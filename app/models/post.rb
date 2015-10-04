require 'previewer'
require 'syntaxer'
require 'cleaner'

class Post < ActiveRecord::Base
  belongs_to :category
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :taggables, as: :tagged
  has_many :tags, through: :taggables

  validates :name, :body, :category_id, presence: true

  after_validation :unescape_and_prepare

  private

  def unescape_and_prepare
    self.body = Cleaner.prepare_text(CGI.unescape(self.body))

    if errors.empty?
      self.pretty_preview = Syntaxer.prepare_html(Previewer.prepare_preview(self.body), false)  # .gsub(/<img[^>]*>/, '')
      self.pretty_body = Syntaxer.prepare_html(self.body)  # .gsub(/<img[^>]*>/, '')
    end
  end
end
