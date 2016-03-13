require "rails_helper"

describe OrdersController do
  describe "POST #create" do
    context "when Slack token is valid" do
      it "calls SaveOrderItemService" do
        expect_any_instance_of(SaveOrderItemService).to receive(:call)

        post :create, token: ENV["OUTGOING_TOKEN"], text: "#happylunch 1", user_name: "cuongvu"
      end

      context "when order items are saved successfully" do
        let(:order_item) { FactoryGirl.create(:order_item) }

        it "calls SlackMessageServices::SendConfirmationMessageToMember" do
          allow_any_instance_of(SaveOrderItemService).to receive(:call).and_return(true)
          allow_any_instance_of(SaveOrderItemService).to receive(:saved_order_items).and_return([order_item])
          expect(SlackMessageServices::SendConfirmationMessageToMember).to receive(:call).with([order_item])

          post :create, token: ENV["OUTGOING_TOKEN"], text: "#happylunch 1", user_name: "cuongvu"
        end
      end
    end

    context "when Slack token is invalid" do
      it "does not call SaveOrderItemService" do
        expect_any_instance_of(SaveOrderItemService).not_to receive(:call)

        post :create, token: "fake-token", text: "#happylunch 1", user_name: "cuongvu"
      end

      it "returns error message" do
        post :create, token: "fake-token", text: "#happylunch 1", user_name: "cuongvu"

        expect(response.body).to eq("{\"error\":\"No access permission\"}")
      end
    end
  end
end
