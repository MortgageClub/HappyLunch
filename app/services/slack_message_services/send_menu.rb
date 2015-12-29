module SlackMessageServices
  class SendMenu < Base
    def self.call
      content = format_content
      send_message(content)
    end

    def self.format_content
      content = ["Menu for today"]
      Dish.today.each do |dish|
        content << "#{dish.item_number}. #{dish.name} #{dish.price} VND"
      end
      content.join("\n")
    end
  end
end
