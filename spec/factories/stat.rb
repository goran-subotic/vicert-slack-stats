FactoryGirl.define do
  factory :stat do
    name { Faker::Internet.user_name }
    msg_count { Faker::Number.between(1, 1000) }
  end
end


