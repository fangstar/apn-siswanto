# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

admin = User.new(
  email: 'mfang@test.com',
  first_name: 'Mitchell', 
  last_name: 'Fang', 
  roles: ['admin'], 
  password: 'mitchell',
  password_confirmation: 'mitchell'
)
admin.skip_confirmation!
admin.save!