class List < ApplicationRecord
  validates :name, presence: true
	has_many :listItems
	accepts_nested_attributes_for :listItems, :allow_destroy => true
end
