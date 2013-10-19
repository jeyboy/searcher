class Tag < ActiveRecord::Base
  has_many :taggables, dependent: :destroy
  has_many :tagged, through: :taggables

  before_validation :to_lowercase

  validates :name, presence: true, uniqueness: true

  protected

  def to_lowercase
    name.downcase!
  end
end
