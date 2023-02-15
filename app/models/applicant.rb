class Applicant < ApplicationRecord
  attr_accessible :email
  validates :email, uniqueness: true, presence: true
end
