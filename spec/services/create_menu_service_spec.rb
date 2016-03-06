require "rails_helper"

describe CreateMenuService do
  describe ".call" do
    let(:menu) do
      [
        {name: "pho", price: 30_000, number: 1},
        {name: "com tam", price: 25_000, number: 2}
      ]
    end

    it "calls GetMenuService" do
      expect(GetMenuService).to receive(:call).and_return(menu)

      described_class.call
    end

    it "calls .init_order" do
      expect(described_class).to receive(:init_order)

      described_class.call
    end

    it "creates new dishes" do
      allow(GetMenuService).to receive(:call).and_return(menu)
      described_class.call
      expect(Dish.all.count).to eq(2)
    end
  end
end
