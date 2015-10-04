class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, #, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts, dependent: :nullify, foreign_key: 'author_id'
end
