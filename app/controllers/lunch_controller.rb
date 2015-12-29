class LunchController < ApplicationController
  before_action :check_request, only: :order
  VALID_TOKEN = "sk15XN8zJl9WodWMHlPWJXuw".freeze

  def menu
    render status: 200, json: Dish.today
  end

  def order
    SaveOrderItemService.call(params)
    render status: 200, json: "order"
  end

  private

  def check_request
    if params["token"] != VALID_TOKEN
      return render json: { error: "No access permission" }, status: 401
    end
  end
end
