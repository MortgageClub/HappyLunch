module SlackMessageServices
  class NotifyPeopleWhoseUnavailableItems < Base
    def self.call(items)
      content = format_content(items)
      send_message(content)
    end

    def self.format_content(items)
      members = items.map { |item| "@#{item.username}" }
      dishes = items.map { |item| item.dish.name if item.dish }.compact.uniq
      to_be  = dishes.size > 1 ? "are" : "is"
      "#{members.join(', ')} Sorry! #{dishes.join(', ')} #{to_be} not available. Please choose others, I'll reorder lunch in five minutes later."
    end
  end
end
