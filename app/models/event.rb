class Event < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  validates :time_begin, presence: true
  validates :time_end, presence: true
end
