FactoryBot.define do
  factory :reward do
    name { Faker::Lorem.characters(number: 20) }
    description { Faker::Lorem.characters(number: 50) }
    points_required { Faker::Number.between(from: 10, to: 100) }
  end
end