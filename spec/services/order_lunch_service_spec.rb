require "rails_helper"

describe OrderLunchService do
  it "calls GetUnavailableItemsService" do
    allow(SubmitOrderService).to receive(:call)
    allow(GetUnavailableItemsService).to receive(:call).and_return([])
    expect(GetUnavailableItemsService).to receive(:call)

    described_class.call
  end

  context "when unavailable_items are empty" do
    it "calls SubmitOrderService" do
      allow(GetUnavailableItemsService).to receive(:call).and_return([])
      expect(SubmitOrderService).to receive(:call)

      described_class.call
    end
  end

  context "when unavailable_items are not empty" do
    before(:each) do
      @unavailable_items = ["1"]
      allow(GetUnavailableItemsService).to receive(:call).and_return(@unavailable_items)
      allow(SlackMessageServices::NotifyPeopleWhoseUnavailableItems).to receive(:call)
    end

    it "calls SlackMessageServices::NotifyPeopleWhoseUnavailableItems" do
      expect(SlackMessageServices::NotifyPeopleWhoseUnavailableItems).to receive(:call).with(@unavailable_items)

      described_class.call
    end

    it "calls SubmitOrderService" do
      # because we call SubmitOrderService as background jobs
      described_class.call

      expect(Delayed::Job.count).to eq(1)
    end
  end
end
