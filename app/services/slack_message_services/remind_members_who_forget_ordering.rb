module SlackMessageServices
  class RemindMembersWhoForgetOrdering < Base
    def self.call
      return unless order && some_members_have_not_ordered_lunch?

      content = format_content
      send_message(content)
    end

    def self.format_content
      username_string = members_have_not_ordered_lunch.map { |member| "@#{member}" }
      "Hey #{username_string.join(', ')}! You haven't ordered lunch yet. Please order now!"
    end

    def self.members_have_not_ordered_lunch
      @members_have_not_ordered_lunch ||= all_members - members_ordered_lunch
    end

    def self.some_members_have_not_ordered_lunch?
      all_members.count > members_ordered_lunch.count
    end

    def self.order
      @order ||= Order.today.first
    end

    def self.members_ordered_lunch
      @members_ordered_lunch ||= order.order_items.pluck(:username).uniq
    end

    def self.all_members
      @all_members ||= GetListMembersService.call
    end
  end
end
