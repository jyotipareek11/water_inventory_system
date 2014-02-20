# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :location do |f|
    f.name "Bangalore"
    f.address1 "82-a laursen court"
    f.city "Bangalore"
  end

end
