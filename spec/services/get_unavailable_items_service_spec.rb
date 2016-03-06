require "rails_helper"

describe GetUnavailableItemsService do
  let(:pho) { FactoryGirl.create(:dish, item_number: 1, name: "pho") }
  let(:today_order) { FactoryGirl.create(:order, created_at: Time.zone.now.beginning_of_day) }
  let!(:order_item) { FactoryGirl.create(:order_item, order: today_order, username: "cuongvu", dish: pho) }

  context "when items are unavailable" do
    it "returns array containing unavailable items" do
      allow(GetMenuService).to receive(:call).and_return([{name: "fish", price: 20_000, number: 2}])
      expect(described_class.call).to eq([order_item])
    end
  end

  context "when all items are available" do
    it "returns an empty array" do
      allow(GetMenuService).to receive(:call).and_return([{name: "pho", price: 20_000, number: 1}])

      expect(described_class.call).to be_empty
    end
  end
end
