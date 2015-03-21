## Validates that the workout does not overlap with any existing workouts
# http://stackoverflow.com/questions/16252423/rails-validate-uniqueness-of-date-ranges

class WorkoutValidator < ActiveModel::Validator
  
  def validate(record)
    if record.challenge.nil?
      record.errors.add :base, 'Workouts are invalid without a challenge'
    # elsif not record.challenge.workouts.exists?
    #   # Do nothing
    else
      overlappers = record.challenge.workouts.where.not(id: record.id).overlaps record.start_date, record.end_date
      if overlappers.exists?
        record.errors.add :base, 'Existing workout for ' + overlappers.first.effective_date
      end
    end
  end

end