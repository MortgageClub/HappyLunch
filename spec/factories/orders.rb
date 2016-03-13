FactoryGirl.define do
  factory :order do |f|
    f.description { "This is description" }

    factory :today_order do
      f.created_at Time.zone.now.beginning_of_day
    end
  end
end
