class SaveOrderItemService
  LUNCH_CODE = "#happylunch".freeze

  def self.call(info)
    return unless today_order

    message = info["text"].gsub!(LUNCH_CODE, "").strip
    numbers = message.split(", ")

    Dish.where(item_number: numbers).each do |dish|
      OrderItem.create(dish: dish, order: today_order, username: info["user_name"])
    end
  end

  private

  def self.today_order
    @today_order ||= Order.today.last
  end
end
