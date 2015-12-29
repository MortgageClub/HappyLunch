namespace :slack do
  task get_menu: :environment do
    GetMenuService.call
  end

  task order_lunch: :environment do
    OrderLunchService.new.call
  end

  task notify_lunch_menu: :environment do
    SlackMessageServices::SendMenu.call
  end

  task notify_user_order: :environment do
    SlackMessageServices::RemindMembersWhoForgetOrdering.call
  end

  task send_success_message: :environment do
    SlackMessageServices::SendSuccessMessage.call
  end
end
