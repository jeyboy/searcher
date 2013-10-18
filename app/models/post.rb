class Post < ActiveRecord::Base
  belongs_to :category
  has_many :taggables, as: :tagged
  has_many :tags, through: :taggables

  accepts_nested_attributes_for :tags
  accepts_nested_attributes_for :category
end
