class Project < ActiveRecord::Base
  belongs_to :owner, class_name: User, foreign_key: "owner_id"
  belongs_to :worker, class_name: User, foreign_key: "worker_id"
  belongs_to :contact, class_name: Contact, foreign_key: "contact_id"
  has_many :tasks
  has_many :feedbacks
  before_save :set_estimated_time


  accepts_nested_attributes_for :tasks, :allow_destroy => true
  accepts_nested_attributes_for :feedbacks, :allow_destroy => true

  validates :name, presence: true
  validates :number, presence: true
  validates :worker, presence: true
  validates :first_feedback, presence: true
    
  enum project_type: [:print, :crea, :other, :creaprint, :creaother, :printother]
  enum priority: [:normal, :urgent]
  enum state: [:running, :waitingclient, :validatedclient, :finished]
  enum progression: [:todocrea, :runningcrea, :finishedcrea, :todoprint, :runningprint, :finishedprint]

  def self.by_owner(id)
      @projects = Project.where(["owner_id = ? AND archived = false", id])
  end
  
  def self.by_profile(id)
    @projects = Project.where(["worker_id = ? AND archived = false", id])
  end

  def self.find_detailed(id)
      @project = Project.includes(:owner, :worker, :contact, :tasks, :feedbacks).find(id)
  end

  def set_estimated_time
    self.estimated_time = @hours * 60 + @minutes
  end
  
  def hours
    self.estimated_time / 60 if self.estimated_time?;
  end
  
  def minutes
    self.estimated_time % 60 if self.estimated_time?;
  end
  
  def hours=(h)
    @hours = h.to_i
  end
  
  def minutes=(m)
   @minutes = m.to_i
  end

end
