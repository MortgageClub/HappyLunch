class LunchController < ApplicationController

  def menu
    #get menu from db
    #convert menu to text
    #call slack api to post messsage to lunch channel
    render status: 200, json: "menu"
  end

  def order
    #receives order info
    #save order info to db
    #check full users order to order lunch
    render status: 200, json: "order"
  end

  def notify
    #call slack api to post success message to lunch channel
    render status: 200, json: "notify"
  end
end
