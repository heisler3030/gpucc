class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :role_ids, :as => :admin
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :time_zone #, :completed_sets_attributes

  has_many :completed_workouts, :dependent => :destroy
  has_many :completed_sets, :dependent => :destroy
  
  has_many :challenge_assignments
  has_many :challenges, :through => :challenge_assignments
  has_many :workouts, :through => :challenges
  has_many :comments

  def current_time
    Time.now.in_time_zone(time_zone)
  end

  def current_date
    current_time.to_date
  end

  # To allow for multiple sets to be created at once
#  accepts_nested_attributes_for :completed_sets,
#    :allow_destroy => true,
#    :reject_if => proc { |a| a['reps'].blank? } 
  
  # TODO: Make this configurable for users
  def email_reminders?
    true
  end

  def reminder_threshold
    10
  end

  # Get total reps for a certain exercise, for a certain date range
  def total(exercise, fromdate=nil, todate=nil)

    if fromdate == nil && todate == nil
      self.completed_sets.where("exercise_id = ?", exercise).sum(:reps)
    else
      puts "NOT YET SUPPORTED"
    end
      
  end

end