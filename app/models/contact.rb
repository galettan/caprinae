class ClientContact < ActiveRecord::Base

belongs_to :client, class_name: Client, foreign_key: "client_id"

validates :last_name, presence: true
validates :first_name, presence: true
validates :email, presence: true

  def self.find_detailed(id)
    @clients = Client.includes(:client_contacts).find(:id)
  end
end