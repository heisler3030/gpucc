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

  # To allow for multiple sets to be created at once
#  accepts_nested_attributes_for :completed_sets,
#    :allow_destroy => true,
#    :reject_if => proc { |a| a['reps'].blank? } 
  
end