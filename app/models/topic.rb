class Topic < ActiveRecord::Base
  attr_accessible :name, :category_id

  has_many :posts, :dependent => :destroy

  validates :name, :presence => true, :length => { :within => 1..512 }, :uniqueness => { :case_sensitive => false }

  before_validation :prepare_name

private
  def prepare_name
    self.name.downcase!
  end
end
