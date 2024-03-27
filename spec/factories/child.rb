FactoryBot.define do
  factory :child do
    name { Faker::Lorem.characters(number: 20) }
    introduction { Faker::Lorem.characters(number: 20) }
    favorite_food { Faker::Lorem.characters(number: 20) }
    future_dream { Faker::Lorem.characters(number: 20) }
    point { Faker::Number.between(from: 0, to: 100) }
    birth_at { Faker::Date.between(from: 10.years.ago, to: Date.today) }
  end
end