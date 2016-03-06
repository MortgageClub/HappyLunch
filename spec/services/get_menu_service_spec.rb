require "rails_helper"

describe GetMenuService do
  describe ".valid_dish?" do
    context "with valid dish" do
      let!(:dish) { FactoryGirl.create(:dish, price: 30_000) }

      it "returns true" do
        expect(described_class.valid_dish?(dish.price)).to eq(true)
      end
    end

    context "with invalid dish" do
      let!(:dish) { FactoryGirl.create(:dish, price: 51_000) }

      it "returns false" do
        expect(described_class.valid_dish?(dish.price)).to eq(false)
      end
    end
  end
end
