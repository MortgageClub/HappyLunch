require "rails_helper"

describe GetMenuService do
  describe ".init_order" do
    context "with no today order" do
      it "creates a new order with day is today" do
        expect { described_class.init_order }.to change(Order, :count).by(1)
      end
    end

    context "with a today order" do
      let!(:order) { FactoryGirl.create(:order) }

      it "does not create a new order" do
        expect { described_class.init_order }.to change(Order, :count).by(0)
      end
    end

    let!(:first_dish) { FactoryGirl.create(:dish, item_number: 1) }
    let!(:second_dish) { FactoryGirl.create(:dish, item_number: 2) }
    it "updates all dishes with item_number nil" do
      described_class.init_order
      expect(Dish.where.not(item_number: nil).count).to eq(0)
    end
  end

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

  describe ".insert_or_update_dish" do
    let!(:dish) { FactoryGirl.create(:dish, name: "Demo", price: 100) }

    context "with existing dish" do
      it "updates dish's attributes" do
        described_class.insert_or_update_dish("Demo", 1000, 4)
        dish.reload
        expect(dish.price).to eq(1000)
      end
    end

    context "with new dish" do
      it "creates new dish" do
        expect { described_class.insert_or_update_dish("Test", 1000, 4) }.to change(Dish, :count).by(1)
      end
    end
  end

  describe ".call" do
    it "calls .init_order" do
      expect(described_class).to receive(:init_order)
      GetMenuService.call
    end

    it "creates or updates list dishes" do
      GetMenuService.call
      expect(Dish.all.count).not_to eq(0)
    end
  end
end
