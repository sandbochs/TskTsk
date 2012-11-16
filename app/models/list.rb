class List < ActiveRecord::Base
  
  attr_accessible :name, :user_id

  validates :name, presence: true

  has_many :tasks, dependant: :destroy
  belongs_to :user, foreign_key: :user_id

end
