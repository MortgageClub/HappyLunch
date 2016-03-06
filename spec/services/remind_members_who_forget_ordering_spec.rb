require "rails_helper"

describe SlackMessageServices::RemindMembersWhoForgetOrdering do
  describe ".call" do
    let!(:today_order) { FactoryGirl.create(:order) }
    let!(:tofu) { FactoryGirl.create(:dish, name: "Tofu", price: 12, item_number: 1) }
    let!(:fruit) { FactoryGirl.create(:dish, name: "Fruit", price: 15, item_number: 2) }
    let!(:order_item1) { FactoryGirl.create(:order_item, order: today_order, username: "tangnv", dish: tofu) }

    it "sends notice message to users have not ordered" do
      VCR.use_cassette("users_have_not_order") do
        allow(GetListMembersService).to receive(:call).and_return(%w(billy cuongvu linhvn09 tangnv))
        expect(SlackMessageServices::Base).to receive(:send_message)
        described_class.call
      end
    end
  end
end
