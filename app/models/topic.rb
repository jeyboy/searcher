class Topic < ActiveRecord::Base
  attr_accessible :name, :category_id

  belongs_to :category, :counter_cache => true
  has_many :posts, :dependent => :destroy

  validates :name, :presence => true, :length => { :within => 1..512 }, :uniqueness => { :case_sensitive => false }

  before_validation :prepare_name


  def as_option
    "<option value='#{self.id}'>#{self.name}</option>"
  end

private
  def prepare_name
    self.name.downcase!
  end
end
