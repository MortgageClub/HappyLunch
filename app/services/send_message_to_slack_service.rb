class SendMessageToSlackService
  def self.call(channel, text, options = {})
    connection = Faraday.new(url: "https://slack.com/api/")
    if options[:link_names]
      response = connection.get "chat.postMessage", channel: channel, token: ENV["SLACK_TOKEN"], text: text, link_names: 1
    else
      response = connection.get "chat.postMessage", channel: channel, token: ENV["SLACK_TOKEN"], text: text
    end
    data = JSON.parse(response.body)
    data["ok"]
  end

  def self.post_lunch_menu_to_slack_lunch(channel)
    call(channel, format_lunch_menu_message)
  end

  def self.remind_user_order(users)
    rs_string = []
    users.each do |member|
      rs_string.push("@#{member}")
    end
    call("#lunch", "Hey #{rs_string.join(', ')}! You haven't ordered lunch yet. Please order now!", {link_names: 1})
  end

  private

  def self.format_lunch_menu_message
    result_text = ["Menu for today"]
    Dish.all.each do |dish|
      result_text.push("#{dish.item_number}. #{dish.name} #{dish.price} VND")
    end
    result_text.join("\n")
  end
end
