class Todo < ActiveRecord::Base
  
  attr_accessible :completed, :completed_at, :description, :list_id, :user_id

  validates :description, presence: true
  validates :list_id, presence: true
  validates :user_id, presence: true

  belongs_to :list, foreign_key: :list_id
  belongs_to :user, foreign_key: :user_id

  scope :active, where(:completed == false)

end
