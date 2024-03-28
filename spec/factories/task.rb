FactoryBot.define do
  factory :task do
    title { Faker::Lorem.characters(number: 20) }
    description { Faker::Lorem.characters(number: 50) }
    point { Faker::Number.between(from: 1, to: 50) }
    num_people { Faker::Number.between(from: 1, to: 10) }
  end
end
