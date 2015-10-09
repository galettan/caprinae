class Client < ActiveRecord::Base

has_many :client_contacts
accepts_nested_attributes_for :client_contacts, :allow_destroy => true

validates :name, presence: true
validates :street, presence: true
validates :town, presence: true
validates :postal_code, presence: true


  def self.find_detailed(id)
    @clients = Client.includes(:client_contacts).find(id)
  end
end