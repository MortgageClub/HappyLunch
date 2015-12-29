require "rails_helper"

describe LunchController do
  describe "GET #menu" do
    context "when there are some dishes" do
      let!(:first_dish) { FactoryGirl.create(:dish, name: "Banh Mi", price: 15_000, item_number: 99) }
      let!(:second_dish) { FactoryGirl.create(:dish, name: "Com Tam", price: 30_000, item_number: 100) }

      it "renders a json which contain array of dishes" do
        get :menu
        expect(response.body).to eq(
          "[{\"id\":1,\"name\":\"Banh Mi\",\"price\":\"15000.0\",\"item_number\":99},{\"id\":2,\"name\":\"Com Tam\",\"price\":\"30000.0\",\"item_number\":100}]"
        )
      end
    end

    context "when there is not any dishes" do
      it "renders an empty json" do
        get :menu
        expect(response.body).to eq("[]")
      end
    end
  end

  describe "POST #order" do
    context "when Slack token is valid" do
      it "calls SaveOrderItemService" do
        expect(SaveOrderItemService).to receive(:call)

        post :order, token: "sk15XN8zJl9WodWMHlPWJXuw",
                     text: "#happylunch 1",
                     user_name: "cuongvu"
      end
    end

    context "when Slack token is invalid" do
      it "does not call SaveOrderItemService" do
        expect(SaveOrderItemService).not_to receive(:call)

        post :order, token: "fake-token",
                     text: "#happylunch 1",
                     user_name: "cuongvu"
      end

      it "returns error message" do
        post :order, token: "fake-token",
                     text: "#happylunch 1",
                     user_name: "cuongvu"

        expect(response.body).to eq("{\"error\":\"No access permission\"}")
      end
    end
  end
end
