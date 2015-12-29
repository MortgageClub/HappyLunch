class Order < ActiveRecord::Base
  has_many :order_items, dependent: :destroy

  scope :today, -> { where("created_at >= ?", Time.zone.now.beginning_of_day) }

  def self.someone_have_not_ordered?
    GetListMembersService.call.uniq.count > self.today.first.order_items.pluck(:username).uniq.count
  end

  def self.existing_today_order?
    self.today.first
  end

  def self.notify_users
    return unless existing_today_order? && someone_have_not_ordered?

    unorder_members = GetListMembersService.call - today.first.order_items.pluck(:username).uniq
    SendMessageToSlackService.remind_member_order(unorder_members)
  end
end
