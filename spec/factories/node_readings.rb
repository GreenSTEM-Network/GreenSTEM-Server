# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :node_reading do
    collection_time "2013-12-07 14:17:24"
    node nil
    soil1 1
    soil2 1
    soil3 1
    temp 1
  end
end
