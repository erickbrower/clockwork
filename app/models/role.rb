class Role < ActiveRecord::Base

  has_many :role_assigments
  has_many :people, through: :role_assignments

end
