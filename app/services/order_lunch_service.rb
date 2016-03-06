class OrderLunchService
  def self.call
    success = true
    unavailable_items = GetUnavailableItemsService.call

    if unavailable_items.empty?
      SubmitOrderService.call
    else
      SlackMessageServices::NotifyPeopleWhoseUnavailableItems.call(unavailable_items)
      OrderLunchService.delay(run_at: 5.minutes.from_now).call
      success = false
    end

    success
  end
end