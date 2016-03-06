require "rails_helper"

describe SlackMessageServices::SendMenu do
  let!(:tofu) { FactoryGirl.create(:dish, name: "Tofu", price: 12, item_number: 1) }
  let!(:fruit) { FactoryGirl.create(:dish, name: "Fruit", price: 15, item_number: 2) }

  describe ".call" do
    it "sends all list of dishes to lunch channel" do
      VCR.use_cassette("list_of_dishes") do
        expect(described_class.call).to be_truthy
      end
    end
  end

  describe ".format_content" do
    it "contains the dish available today" do
      expect(described_class.format_content).to include "Tofu"
    end
  end
end
