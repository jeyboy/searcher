class Post < ActiveRecord::Base
  belongs_to :category
  has_many :taggables, as: :tagged
  has_many :tags, through: :taggables

  validates :name, :body, presence: true
end
