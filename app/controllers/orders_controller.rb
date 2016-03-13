class OrdersController < ApplicationController
  before_action :check_request, only: :create

  def create
    service = SaveOrderItemService.new(params)

    if service.call
      SlackMessageServices::SendConfirmationMessageToMember.call(service.saved_order_items)
    end

    render status: 200, json: "create"
  end

  private

  def check_request
    return render json: {error: "No access permission"}, status: 401 if params["token"] != ENV["OUTGOING_TOKEN"]
  end
end
