FactoryBot.define do
  factory :child do
    name { Faker::Name.first_name }
    introduction { Faker::Lorem.paragraph }
    favorite_food { Faker::Food.dish }
    future_dream { Faker::Job.title }
    point { Faker::Number.between(from: 0, to: 100) }

  end
end