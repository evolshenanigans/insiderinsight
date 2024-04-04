# lib/tasks/sample_data.rake
namespace :db do
  desc "Generate sample data for Officials, Stocks, Users, and Trades"
  task generate_sample_data: :environment do
    require 'faker'

    # Delete previous faker inputs
    Trade.delete_all
    Official.delete_all
    Stock.delete_all
    User.delete_all

    puts "Previous sample data deleted. Generating new sample data..."

    # Adjusted generation for Officials
    10.times do
      Official.create(
        name: Faker::Name.name,

      )
    end

    # Adjusted generation for Stocks
    10.times do
      Stock.create(
        name: Faker::Company.name,
      )
    end

    # Adjusted generation for Users
    10.times do
      User.create(
        name: Faker::Name.name,
        email: Faker::Internet.email,
        password: Faker::Internet.password
      )
    end

    # Adjusted generation for Trades
    10.times do
      Trade.create(
        official_id: Official.order('RANDOM()').first.id,
        stock_id: Stock.order('RANDOM()').first.id,
        user_id: User.order('RANDOM()').first.id,
        transaction_type: [:buy, :sell].sample,
        transaction_count: Faker::Number.between(from: 1, to: 100),
        security_type: ['Equity', 'Bond', 'ETF'].sample
      )
    end
  end
end
