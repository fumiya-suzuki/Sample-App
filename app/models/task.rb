class Task < ApplicationRecord
  belongs_to :user
  
  validates :name, presence: true
  validates :note, presence: true
  validates :user_id, presence: true
end
