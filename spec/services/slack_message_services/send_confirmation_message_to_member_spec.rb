require "rails_helper"

describe SlackMessageServices::SendConfirmationMessageToMember do
  let(:pho) { FactoryGirl.create(:dish, item_number: 1, name: "pho") }
  let(:order_item) { FactoryGirl.create(:order_item, username: "cuongvu", dish: pho) }
  let(:message) { "@cuongvu We received your order: pho. Thank you for your order!" }

  describe ".format_content" do
    it "formats a proper content" do
      expect(described_class.format_content([order_item])).to eq(message)
    end
  end

  describe ".call" do
    it "calls .format_content" do
      expect(described_class).to receive(:format_content).with(order_item)

      described_class.call(order_item)
    end

    it "calls .send_message" do
      allow(described_class).to receive(:format_content).with(order_item).and_return(message)
      expect(described_class).to receive(:send_message).with(message)

      described_class.call(order_item)
    end
  end
end
