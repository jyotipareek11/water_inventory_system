# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# creating default admin

if User.count == 0
  puts "Creating admin user........"
  User.create!(:role=>:admin, :first_name=>'Admin', :email=>"admin@waterinventory.com", :password=>"password")
  puts "Admin created successfully....."
end
