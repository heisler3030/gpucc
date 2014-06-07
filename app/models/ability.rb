class Ability
  include CanCan::Ability

    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities


  def initialize(user)
    user ||= User.new # guest user (not logged in)

     # Guest users should have no privileges
     # Admin should be able to manage everything, including users
     # Trainers should be able to create challenges and manage their own challenges and sub-elements
     #     Eg. workouts, challenge assignments, completedworkouts where they are marked as owner
     # Users should be able to create/edit/destroy completedsets and edit users provided they are self

#------------ Guest Privileges ------------------------------------------------

  can [:create], Applicant

# ------------ Admin Privileges ------------------------------------------------

    if user.has_role? :admin
      can :manage, :all
    
# ------------ Trainer Privileges ----------------------------------------------

    elsif user.has_role? :trainer
      can :read, :all
      can [:manage,:manageparticipants], Challenge, :owner_id => user.id
      can :manage, ChallengeAssignment, :challenge => {:owner_id => user.id }  
      can :manage, Workout, :challenge => {:owner_id => user.id }      

# ------------ User Privileges -------------------------------------------------

    elsif user.has_role? :user
      can [:read, :update], User, :id => user.id  # Can update their own profile
      can [:read], Challenge
      can [:read], ChallengeAssignment
      can [:create], ChallengeAssignment, :user_id => user.id
      can [:create], CompletedSet, :user_id => user.id
      can [:update, :delete], CompletedSet do |cs| 
        cs.workout.active?(user) && user.id == cs.user_id  # Only edit current workouts for yourself
      end
      can [:manage], Comment, :user_id => user.id  # TODO: Probably want to restrict destroy?
      can [:read], Workout
    end

  end
end
