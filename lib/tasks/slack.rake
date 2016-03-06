namespace :slack do
  task get_menu: :environment do
    CreateMenuService.call
    SlackMessageServices::SendMenu.call
  end

  task remind_members_order_lunch: :environment do
    SlackMessageServices::RemindMembersWhoForgetOrdering.call
  end

  task order_lunch: :environment do
    if OrderLunchService.call
      SlackMessageServices::SendSuccessMessage.call
    end
  end
end
