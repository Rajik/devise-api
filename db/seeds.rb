# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create!(email: 'test01@gmail.com', password: '12345678')
User.create!(email: 'test02@gmail.com', password: '12345678')
User.create!(email: 'test03@gmail.com', password: '12345678')
User.create!(email: 'test04@gmail.com', password: '12345678')
