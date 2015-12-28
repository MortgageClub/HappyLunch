require "rails_helper"

describe SendMessageToSlackService do
  let!(:tofu) {Dish.create(name: "Tofu", price: 12)}
  let!(:fruit) {Dish.create(name: "Fruit", price: 15)}
  it "returns text that user want to send to lunch" do
    expect(described_class.call("#lunch").to_s).to include "Tofu"
  end
end
