class Client < ActiveRecord::Base

  has_many :contacts
  accepts_nested_attributes_for :contacts, :allow_destroy => true
  
  validates :name, presence: true
  validates :street, presence: true
  validates :city, presence: true
  validates :postal_code, presence: true

  scope :search_name, -> (name) {where("name LIKE ?", "#{name}%")}
  scope :contact_email, -> (email) {distinct.joins('LEFT JOIN contacts ON contacts.client_id = clients.id')
    .where('contacts.email LIKE ? ', email)}


  def self.find_detailed(id)
    @clients = Client.includes(:contacts).find(id)
  end
end