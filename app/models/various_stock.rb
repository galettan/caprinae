class VariousStock < ApplicationRecord

  validates :name, presence: true
	has_many :variousStockItems
	accepts_nested_attributes_for :variousStockItems, :allow_destroy => true

  def self.find_detailed(id)
    @variousstocks = VariousStock.includes(:variousStock).find(id)
  end
end
