class Taggable < ActiveRecord::Base
  has_paper_trail

  belongs_to :tagged, polymorphic: true
  belongs_to :tag

  validates :tag_id, uniqueness: {scope: :tagged_id}

  scope :for_posts, -> { tagged_type == 'Post' }
end
