class PaperstockItem < ActiveRecord::Base

belongs_to :paperstock, class_name: Paperstock, foreign_key: "paperstock_id"

validates :name, presence: true
before_update :set_defaults

    def set_defaults
      self.thirtytwofortyfive = 0 if self.thirtytwofortyfive.nil?
      self.fiftytwoseventytwo = 0 if self.fiftytwoseventytwo.nil?
      self.toorder = 0 if self.toorder.nil?
    end

end