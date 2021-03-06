# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user1 = User.create!(name: 'Ruparna Mukherjee',
                     email: 'ruparna.mukherjee@kreeti.com',
                     password: 'password',
                     password_confirmation: 'password',
                     admin: true)
user1.build_section(employee: true, brand: true, category: true, item: true, storage: true, issue: true).save!
