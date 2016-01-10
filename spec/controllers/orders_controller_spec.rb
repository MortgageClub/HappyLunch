require "rails_helper"

describe OrdersController do
  describe "POST #create" do
    context "when Slack token is valid" do
      it "calls SaveOrderItemService" do
        expect(SaveOrderItemService).to receive(:call)

        post :create, token: ENV["OUTGOING_TOKEN"], text: "#happylunch 1", user_name: "cuongvu"
      end
    end

    context "when Slack token is invalid" do
      it "does not call SaveOrderItemService" do
        expect(SaveOrderItemService).not_to receive(:call)

        post :create, token: "fake-token", text: "#happylunch 1", user_name: "cuongvu"
      end

      it "returns error message" do
        post :create, token: "fake-token", text: "#happylunch 1", user_name: "cuongvu"

        expect(response.body).to eq("{\"error\":\"No access permission\"}")
      end
    end
  end
end
