class LunchController < ApplicationController
  before_action :check_request, only: :order

  def order
    SaveOrderItemService.call(params)
    render status: 200, json: "order"
  end

  private

  def check_request
    return render json: {error: "No access permission"}, status: 401 if params["token"] != ENV["OUTGOING_TOKEN"]
  end
end
