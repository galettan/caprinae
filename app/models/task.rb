class Task < ActiveRecord::Base
  belongs_to :project, class_name: Project, foreign_key: "project_id"
  belongs_to :worker, class_name: User, foreign_key: "worker_id"
  
  validates :description, presence: true
  before_save :set_duration
 
  def set_duration
    self.duration = @hours * 60 + @minutes
  end
  
  def hours
    self.duration / 60 if self.duration?;
  end
  
  def minutes
    self.duration % 60 if self.duration?;
  end
  
  def hours=(h)
    @hours = h.to_i
  end
  
  def minutes=(m)
   @minutes = m.to_i
  end
  
  # def duration=(d)
    # @hours = d / 60
    # @minutes = d % 60
    # self.set_duration
  # end
end