require "rails_helper"

RSpec.describe OrderItem do
  it { should validate_presence_of(:dish_id) }
  it { should validate_presence_of(:order_id) }
  it { should validate_presence_of(:username) }
end
