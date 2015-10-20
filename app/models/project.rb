class Project < ActiveRecord::Base
  belongs_to :owner, class_name: User, foreign_key: "owner_id"
  belongs_to :worker, class_name: User, foreign_key: "worker_id"
  belongs_to :contact, class_name: Contact, foreign_key: "contact_id"
  
  validates :name, presence: true
  validates :number, presence: true
  validates :worker, presence: true
  validates :first_feedback, presence: true
  
  PROJECT_TYPES = {
    :print => 0,
    :crea => 1,
    :other => 2,
    :creaprint => 3,
    :creaother => 4,
    :printother => 5
  }
  PPROJECT_PRIORITY = {
    :normal => 'Normal',
    :urgent => 'Urgent'
  }
  
  enum project_type: [:print, :crea, :other, :creaprint, :creaother, :printother]
  enum priority: [:normal, :urgent]
  enum state: [:running, :waitingclient, :validatedclient, :finished]

  def self.by_owner(id)
      @projects = Project.where(["owner_id = ? AND archived = false", id])
  end
  
  def self.by_profile(id)
    @projects = Project.where(["worker_id = ? AND archived = false", id])
  end

  def self.find_detailed(id)
      @project = Project.includes(:owner, :worker, :contact).find(id)
  end

end
