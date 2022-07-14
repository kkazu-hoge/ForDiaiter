FactoryBot.define do
  factory :customer do
    email {Faker::Internet.email}
    password {"A12345"}
    last_name { Faker::Name.last_name }
    first_name { Faker::Name.first_name }
    public_name { Faker::Name.name }
    sex {"man"}
    birthday {"1993-09-28"}
    height { Faker::Number.between(from: 140, to: 200) }
    weight { Faker::Number.between(from: 40, to: 130) }
  end
end



