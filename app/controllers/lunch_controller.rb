class LunchController < ApplicationController

  def sends_menu_to_slack
    #get menu from db
    #convert menu to text
    #call slack api to post messsage to lunch channel
    render status: 200, json: "sends_menu_to_slack"
  end

  def receives_order_info_and_process
    #receives order info
    #save order info to db
    #check full users order to order lunch
    render status: 200, json: "receives_order_info_and_process"
  end

  def sends_success_message_to_slack
    #call slack api to post success message to lunch channel
    render status: 200, json: "sends_success_message_to_slack"
  end
end
