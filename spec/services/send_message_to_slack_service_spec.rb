require "rails_helper"

describe SendMessageToSlackService do
  let!(:tofu) {Dish.create(name: "Tofu", price: 12)}
  let!(:fruit) {Dish.create(name: "Fruit", price: 15)}
  it "Sends all list of dishes to lunch channel" do
    expect(described_class.call("#lunch").to_s).to include "Tofu"
  end
end
