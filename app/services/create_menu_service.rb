class CreateMenuService
  def self.call
    init_order
    menu = GetMenuService.call

    menu.each do |food|
      dish = Dish.find_or_initialize_by(name: food[:name])
      dish.price = food[:price]
      dish.item_number = food[:number]
      dish.save
    end
  end

  def self.init_order
    Order.create(order_date: Time.zone.now) unless Order.today.first
    Dish.update_all(item_number: nil)
  end
end
