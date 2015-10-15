class Project < ActiveRecord::Base
  belongs_to :owner, class_name: User, foreign_key: "owner_id"
  belongs_to :worker, class_name: User, foreign_key: "worker_id"
  belongs_to :contact, class_name: Contact, foreign_key: "contact_id"
  
  validates :name, presence: true
  validates :number, presence: true
  validates :worker, presence: true
  validates :first_feedback, presence: true
  
  enum project_type: [:print, :crea, :printcrea]

  def self.find_detailed(id)
      @project = Project.includes(:owner, :worker, :contact).find(id)
  end

end
