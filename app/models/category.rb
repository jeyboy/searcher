class Category < ActiveRecord::Base
  LANGS = %w(bash coffeescript css erb haml html javascript json ruby sql xml yaml)

  has_many :posts, dependent: :nullify

  validates :name, presence: true, uniqueness: true
end
