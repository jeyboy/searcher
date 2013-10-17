class Tag < ActiveRecord::Base
  has_many :taggables, dependent: :destroy
  has_many :tagged, through: :taggables
end
