module SlackMessageServices
  class SendSuccessMessage < Base
    def self.call
      return if order_items.empty?

      content = format_content
      send_message(content)
    end

    def self.format_content
      content = ["<!here> We have ordered lunch successfully. :dancer:"]
      order_items.all.each do |item|
        content << "*#{item.username}* #{item.dish.name}"
      end
      content.join("\n")
    end

    private

    def self.order_items
      return [] unless Order.today.last
      Order.today.last.order_items
    end
  end
end
