# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Environment variables (ENV['...']) are set in the file config/application.yml.
# See http://railsapps.github.com/rails-environment-variables.html

adminRole = Role.create! :name => 'admin'
userRole = Role.create! :name => 'user'

puts 'SETTING UP DEFAULT USER LOGIN'
user = User.create! :email => 'user@example.com', :password => 'password1', :password_confirmation => 'password1', :name => 'John Doe'
user2 = User.create! :email => 'user2@example.com', :password => 'password1', :password_confirmation => 'password1', :name => 'Jane Doe'

user.add_role :admin
user2.add_role :user

unless Site.find_by_name("Drexel URBN Center")
  site = Site.new :name => "Drexel URBN Center", :description => "This is a test site at the TechCamp hackathon", :address => "3501 Market Street", :zipcode => 19104

  site.save
end

site = Site.find_by_name("Drexel URBN Center")

if site.nodes.empty?
  site.nodes.create(channel: 001, project_type: 'garden')
end
