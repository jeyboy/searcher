require 'previewer'
require 'syntaxer'
require 'cleaner'

class Post < ActiveRecord::Base
  has_paper_trail

  belongs_to :category
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :taggables, as: :tagged
  has_many :tags, through: :taggables

  validates :name, :body, :category_id, presence: true

  before_validation :unescape

  private

  def unescape
    self.body = CGI.unescape(self.body)
    doc = Nokogiri::HTML(self.body)
    self.preview = Syntaxer.prepare_html(Cleaner.prepare_nokogiri(Previewer.prepare_preview(doc.dup, self.body.length)).gsub(/<img[^>]*>/, ''), false)

    unless self.id
      self.body = Syntaxer.prepare_html(Cleaner.prepare_nokogiri(doc))
    end
  end
end
