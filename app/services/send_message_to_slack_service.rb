class SendMessageToSlackService
  def self.call(channel)
    connection = Faraday.new(url: "https://slack.com/api/")
    response = connection.get "chat.postMessage", channel: channel, token: ENV["SLACK_TOKEN"], text: format_message

    data = JSON.parse(response.body)
    if data["ok"]
      text = data["message"]
    end
    text
  end

  private

  def self.format_message
    dishes = Dish.all
    result_text = ["Today list"]
    dishes.each_with_index do |dish, index|
      result_text.push("#{index+1}. #{dish.name} #{dish.price}")
    end
    result_text.join("\n")
  end
end
