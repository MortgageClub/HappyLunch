class LunchController < ApplicationController

  def sends_menu
    #get menu from db
    #convert menu to text
    #call slack api to post messsage to lunch channel
    render status: 200, json: "sends_menu"
  end

  def processes_order
    #receives order info
    #save order info to db
    #check full users order to order lunch
    render status: 200, json: "processes_order"
  end

  def notify_success
    #call slack api to post success message to lunch channel
    render status: 200, json: "notify_success"
  end
end
