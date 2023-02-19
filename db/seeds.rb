# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Environment variables (ENV['...']) can be set in the file config/application.yml.
# See http://railsapps.github.io/rails-environment-variables.html
puts 'ROLES'
YAML.load(ENV['ROLES']).each do |role|
  Role.find_or_create_by(name: role)
  puts 'role: ' << role
end


puts 'DEFAULT USERS'
user = User.find_or_create_by(email: ENV['ADMIN_EMAIL'].dup) do |u|
	u.name = ENV['ADMIN_NAME'].dup
	u.email = ENV['ADMIN_EMAIL'].dup
	u.password = ENV['ADMIN_PASSWORD'].dup
	u.password_confirmation = ENV['ADMIN_PASSWORD'].dup
end
puts 'user: ' << user.email
user.add_role :admin

# Test Users
[
	{name: 'Valentino Rossi', email: 'rossi@gpucc.com', password: 'changeme', password_confirmation: 'changeme'},
	{name: 'Dani Pedrosa', email: 'pedrosa@gpucc.com', password: 'changeme', password_confirmation: 'changeme'},
	{name: 'Casey Stoner', email: 'stoner@gpucc.com', password: 'changeme', password_confirmation: 'changeme'},
	{name: 'Lee Atkins', email: 'lee@gpucc.com', password: 'changeme', password_confirmation: 'changeme'},
].each do |u|
	user = User.find_or_create_by(email: u[:email]) do |u|
		user.name = u[:name]
		user.email = u[:email]
		user.password = u[:password]
		user.password_confirmation = u[:password_confirmation]
	end
	puts 'user: ' << user.email
	user.add_role :user
end


# Seed Exercises
[
	{name: 'Pushups'},
	{name: 'Situps'},
	{name: 'Pullups'},
	{name: 'Burpees'},
	{name: 'Jumping Jacks'}
].each do |e|
	Exercise.find_or_create_by(name: e[:name])
end

# Seed Goal Types
[
	{title: 'Cumulative', description: 'Total amount to be completed during workout period'},
	{title: 'One Set', description: 'Complete as specified in one continuous effort'}
].each do |g|
	GoalType.find_or_create_by(title: g[:title])
end