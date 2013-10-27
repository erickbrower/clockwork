# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

ROLES.each { |role_name| Role.create(title: role_name) }

#Create a default administrator account
Person.create({
  email: 'admin@clockwork.test',
  password: '12345678',
  password_confirmation: '12345678',
  time_zone: "Pacific Time (US & Canada)",
  profile_attributes: {  
    first_name: 'Administrator',
    last_name: 'Guy',
    birthdate: 28.years.ago
  },
  role_ids: [
    Role.where(title: :administrator).first.id
  ]
})
