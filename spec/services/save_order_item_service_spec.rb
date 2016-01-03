require "rails_helper"

describe SaveOrderItemService do
  context "with existing items" do
    let!(:order) { FactoryGirl.create(:order) }
    let(:first_dish) { FactoryGirl.create(:dish) }
    let(:second_dish) { FactoryGirl.create(:dish) }
    let(:third_dish) { FactoryGirl.create(:dish) }

    context "when member orders one dish" do
      before(:each) do
        @info = {
          "token" => ENV["OUTGOING_TOKEN"],
          "team_id" => "YOUR_SLACK_TEAM_ID",
          "team_domain" => "mortgageclub",
          "service_id" => "SLACK_SERVICE_ID",
          "channel_id" => "YOUR_SLACK_CHANNEL_ID",
          "channel_name" => "lunch",
          "timestamp" => "1451291717.000030",
          "user_id" => "SLACK_USER_ID",
          "user_name" => "cuongvu",
          "text" => "#happylunch #{first_dish.item_number}",
          "trigger_word" => "#happylunch",
          "controller" => "lunch",
          "action" => "order"
        }
      end

      it "creates a new order item" do
        expect { described_class.call(@info) }.to change { OrderItem.count }.by(1)
      end
    end

    context "when member orders several dishes" do
      before(:each) do
        @info = {
          "token" => ENV["OUTGOING_TOKEN"],
          "team_id" => "YOUR_SLACK_TEAM_ID",
          "team_domain" => "mortgageclub",
          "service_id" => "SLACK_SERVICE_ID",
          "channel_id" => "YOUR_SLACK_CHANNEL_ID",
          "channel_name" => "lunch",
          "timestamp" => "1451291717.000030",
          "user_id" => "SLACK_USER_ID",
          "user_name" => "cuongvu",
          "text" => "#happylunch #{first_dish.item_number}, #{second_dish.item_number}, #{third_dish.item_number}",
          "trigger_word" => "#happylunch",
          "controller" => "lunch",
          "action" => "order"
        }
      end

      it "creates new order items" do
        expect { described_class.call(@info) }.to change { OrderItem.count }.by(3)
      end
    end
  end

  context "with non-existing items" do
    before(:each) do
      @info = {
        "token" => ENV["OUTGOING_TOKEN"],
        "team_id" => "YOUR_SLACK_TEAM_ID",
        "team_domain" => "mortgageclub",
        "service_id" => "SLACK_SERVICE_ID",
        "channel_id" => "YOUR_SLACK_CHANNEL_ID",
        "channel_name" => "lunch",
        "timestamp" => "1451291717.000030",
        "user_id" => "SLACK_USER_ID",
        "user_name" => "cuongvu",
        "text" => "#happylunch faker-item",
        "trigger_word" => "#happylunch",
        "controller" => "lunch",
        "action" => "order"
      }
    end

    it "does not save any dishes" do
      expect { described_class.call(@info) }.not_to change { OrderItem.count }
    end
  end
end
