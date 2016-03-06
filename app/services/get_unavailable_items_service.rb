class GetUnavailableItemsService
  def self.call
    items = Order.today.first.order_items
    # [{name: "fish", price: 20000, number: 1}]
    menu = GetMenuService.call

    unavailable_items = items.map do |item|
      next unless (dish = item.dish)
      available = menu.select { |m| m[:name] == dish.name }.any?

      item unless available
    end

    unavailable_items.compact
  end
end
