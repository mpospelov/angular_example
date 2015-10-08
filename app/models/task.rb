class Task < ActiveRecord::Base
  belongs_to :user
  validates :duration, :date, :description, presence: true
end
