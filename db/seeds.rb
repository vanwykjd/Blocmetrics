# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
  3.times do
        User.create!(
            username: Faker::Internet.user_name,
            email: Faker::Internet.safe_email,
            password: "password",
            password_confirmation: "password",
            unconfirmed_email: false,
            confirmed_at: Faker::Time.between(DateTime.now - 1, DateTime.now)
        )
    end
    users = User.all
    
    30.times do
        RegisteredApplication.create!(
            user: users.sample,
            name: Faker::App.name,
            url: Faker::Internet.domain_name
        )
    end
    apps = RegisteredApplication.all
    
    50.times do
        Event.create!(
            registered_application: apps.sample,
            name: Faker::Hacker.verb
        )
    end
    
    
    
    puts "Seed finished"
    puts "#{User.count} users created"
    puts "#{RegisteredApplication.count} apps created"
    puts "#{Event.count} events created"