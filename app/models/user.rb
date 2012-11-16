class User < ActiveRecord::Base
  
  attr_accessible :username, :password, :password_confirmation

  has_secure_password

  validates :username, presence: true, uniqueness: true, length: { minimum: 4 }
  validates :password, presence: true, on: create
  validates :password_confirmation, presence: true, on: create

  has_many :lists, dependent: :destroy
  has_many :todos, dependent: :destroy

end
