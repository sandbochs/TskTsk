class List < ActiveRecord::Base
  
  attr_accessible :name, :user_id

  validates :name, presence: true
  #validates :user_id, presence: true

  has_many :todos, dependent: :destroy
  belongs_to :user, foreign_key: :user_id

end
