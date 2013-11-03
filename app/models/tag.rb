class Tag < ActiveRecord::Base
  has_paper_trail

  has_many :taggables, dependent: :destroy
  has_many :posts, through: :taggables, source_type: 'Post', source: :tagged
  #has_many :categories, through: :taggables, source_type: 'Category', source: :tagged

  before_validation :to_lowercase

  validates :name, presence: true, uniqueness: true

  protected

  def to_lowercase
    name.downcase!
  end
end
