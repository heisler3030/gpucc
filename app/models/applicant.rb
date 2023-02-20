class Applicant < ApplicationRecord
  validates :email, uniqueness: true, presence: true
end
