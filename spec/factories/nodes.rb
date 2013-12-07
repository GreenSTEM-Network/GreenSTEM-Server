# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :node do
    channel 1
    project_type "MyString"
    voltage 1
    site nil
  end
end
