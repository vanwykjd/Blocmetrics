FactoryGirl.define do
  factory :registered_application do
    user 
    name { Faker::Internet.domain_name }
    url { Faker::Internet.url }
  end
end
