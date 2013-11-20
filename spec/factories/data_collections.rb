# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :data_collection do
    collected_date "2013-02-23 14:24:21"
    soil_moisture_low "9.99"
    soil_moisture_medium "9.99"
    soil_moisture_high "9.99"
    temperature "9.99"
    sunlight "9.99"
    waterlevel "9.99"
  end
end
