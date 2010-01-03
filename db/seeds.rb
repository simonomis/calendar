# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)

Category.create([
  { :name => "Home", :color => "#96AF97" },
  { :name => "Work", :color => "#ACA297" },
  { :name => "Baseball", :color => "#D28775" },
  { :name => "Birthdays", :color => "#B1B1B1" },
  { :name => "Holidays", :color => "#98A4AF" },
  ])
