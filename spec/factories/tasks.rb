FactoryGirl.define do
  factory :task do
    description { Faker::Lorem.sentence }
    duration { rand(10..200) }
    date { Faker::Date.backward(14) }
  end
end
