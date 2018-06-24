class Paperstock < ApplicationRecord

  validates :name, presence: true
  has_many :paperstock_items
  accepts_nested_attributes_for :paperstock_items, :allow_destroy => true

  def self.find_detailed(id)
    @paperstocks = Paperstock.includes(:papers).find(id)
  end
end
