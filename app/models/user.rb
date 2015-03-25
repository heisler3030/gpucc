class User < ActiveRecord::Base

  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Remember to add to application_controller.rb if these change
  attr_accessible :role_ids, :as => :admin
  attr_accessible :name, :email, :password, :password_confirmation,
   :remember_me, :time_zone, :reminder_threshold, :notifications #, :completed_sets_attributes

  has_many :challenges, :through => :challenge_assignments
  has_many :workouts, :through => :challenges
  has_many :comments

  # Delete all these if the user is deleted
  has_many :completed_workouts, :dependent => :delete_all #:destroy
  has_many :completed_sets, :dependent => :delete_all #:destroy
  has_many :challenge_assignments, :dependent => :delete_all #:destroy
  has_many :comments, :dependent => :delete_all #:destroy

  validates :name, uniqueness: true, presence: true
  validates :email, uniqueness: true, presence: true

  scope :invited, -> { where('invitation_token IS NOT NULL') }

  # Put all users in "User" role by default
  after_create :assign_default_role
  def assign_default_role
    add_role(:user)
  end

## Instance Methods

  # Return name and role
  def name_with_role
    name + " (" + self.roles.first.name.titlecase + ")"
  end

  # Return current_time for this user
  def current_time
    Time.now.in_time_zone(time_zone)
  end

  # Return current_date for this user
  def current_date
    self.current_time.to_date
  end
  
  def email_reminders?
    not(reminder_threshold == 0)
  end

  def workout_notifications?
    notifications
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