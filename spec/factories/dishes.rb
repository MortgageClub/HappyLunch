FactoryGirl.define do
  factory :dish do |f|
    f.name { FFaker::Food.ingredient }
    f.price { rand(100_000) }
    f.item_number { rand(100) }
  end
end
