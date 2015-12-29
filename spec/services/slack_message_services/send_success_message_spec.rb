require "rails_helper"

describe SlackMessageServices::SendSuccessMessage do
  context "with existing order items" do
    let(:order) { FactoryGirl.create(:order) }
    let(:first_dish) { FactoryGirl.create(:dish) }
    let(:second_dish) { FactoryGirl.create(:dish) }
    let!(:first_order_item) { FactoryGirl.create(:order_item, order: order, dish: first_dish) }
    let!(:second_order_item) { FactoryGirl.create(:order_item, order: order, dish: second_dish) }

    it "returns true" do
      expect(described_class.call).to be_truthy
    end

    it "sends a success message with proper content" do
      expect(described_class.format_content).to eq(
        "<!here> We have ordered lunch successfully. :dancer:\n**#{first_order_item.username}** #{first_order_item.dish.name}\n**#{second_order_item.username}** #{second_order_item.dish.name}"
      )
    end
  end

  context "with non order items" do
    it "does nothing and return nothign" do
      expect(described_class.call).to be_falsey
    end
  end
end
