class LunchController < ApplicationController
  before_action :check_request, only: :order
  VALID_TOKEN = "sk15XN8zJl9WodWMHlPWJXuw".freeze

  def menu
    # get menu from db
    # convert menu to text
    # call slack api to post messsage to lunch channel
    GetMenuService.call
    order = OrderLunchService.new
    order.call
    render status: 200, json: Dish.today
  end

  def order
    # receives order info
    # save order info to db
    # check full users order to order lunch
    render status: 200, json: "order"
  end

  private

  def check_request
    return if params["token"] != VALID_TOKEN
  end
end
