FactoryBot.define do
  factory :task do
    name { Faker::Lorem.characters(number: 20) }
    description { Faker::Lorem.characters(number: 50) }
    points { Faker::Number.between(from: 1, to: 50) }
    due_date { Faker::Date.forward(days: 30) }
  end
end
