require "rails_helper"

describe SlackMessageServices::NotifyPeopleWhoseUnavailableItems do
  let(:pho) { FactoryGirl.create(:dish, item_number: 1, name: "pho") }
  let(:tofu) { FactoryGirl.create(:dish, item_number: 2, name: "tofu") }
  let(:today_order) { FactoryGirl.create(:order, created_at: Time.zone.now.beginning_of_day) }
  let(:first_item) { FactoryGirl.create(:order_item, order: today_order, username: "cuongvu", dish: pho) }
  let(:second_item) { FactoryGirl.create(:order_item, order: today_order, username: "tangnv", dish: tofu) }

  describe ".format_content" do
    context "with one member" do
      it "formats a proper content" do
        expect(described_class.format_content([first_item])).to eq("@cuongvu Sorry! pho is not available. Please choose others, I'll reorder lunch in five minutes later.")
      end
    end

    context "with many members" do
      it "formats a proper content" do
        expect(described_class.format_content([first_item, second_item])).to eq(
          "@cuongvu, @tangnv Sorry! pho, tofu are not available. Please choose others, I'll reorder lunch in five minutes later."
        )
      end
    end
  end

  describe ".call" do
    it "calls .format_content" do
      items = [first_item, second_item]
      expect(described_class).to receive(:format_content).with(items)
      described_class.call(items)
    end
  end
end
