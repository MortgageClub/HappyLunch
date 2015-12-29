namespace :slack do
  desc "Notify Lunch Menu"
  task :notify_lunch_menu => :environment do
    puts "Notifying lunch menu job is running"
    GetMenuService.call
    SendMessageToSlackService.post_lunch_menu_to_slack_lunch("#lunch")
    puts "Notifying lunch is running on background"
  end
end