FactoryGirl.define do
  factory :order_item do |f|
    order
    dish
    f.username { FFaker::Internet.user_name }
  end
end
