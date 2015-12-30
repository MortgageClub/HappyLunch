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
          "token" => "sk15XN8zJl9WodWMHlPWJXuw",
          "team_id" => "T041L28A7",
          "team_domain" => "mortgageclub",
          "service_id" => "17449929782",
          "channel_id" => "C08MCMJ8K",
          "channel_name" => "lunch",
          "timestamp" => "1451291717.000030",
          "user_id" => "U08G38YBC",
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
          "token" => "ak15XN8zJl9WodWMHlPWJXvz",
          "team_id" => "T041L28B9",
          "team_domain" => "mortgageclub",
          "service_id" => "17449929782",
          "channel_id" => "C08MCMJ8K",
          "channel_name" => "lunch",
          "timestamp" => "1451291717.000030",
          "user_id" => "U09Z78YBC",
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
        "token" => "sk15XN8zJl9WodWMHlPWJXuw",
        "team_id" => "T041L28A7",
        "team_domain" => "mortgageclub",
        "service_id" => "17449929782",
        "channel_id" => "C08MCMJ8K",
        "channel_name" => "lunch",
        "timestamp" => "1451291717.000030",
        "user_id" => "U08G38YBC",
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
