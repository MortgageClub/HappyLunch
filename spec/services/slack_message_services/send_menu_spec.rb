require "rails_helper"

describe SlackMessageServices::SendMenu do
  let!(:tofu) { Dish.create(name: "Tofu", price: 12) }
  let!(:fruit) { Dish.create(name: "Fruit", price: 15) }

  it "Sends all list of dishes to lunch channel" do
    VCR.use_cassette("list_of_dishes") do
      expect(described_class.call).to be_truthy
    end
  end
end
