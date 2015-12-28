class GetListMembersService
  def self.call
    connection = Faraday.new(url: "https://slack.com/api/")
    response = connection.get "users.list", token: ENV["SLACK_TOKEN"], presence: true, pretty: 1
    data = JSON.parse(response.body)
    members = []

    if data["ok"]
      members = data["members"].map! { |member| member["name"] if valid_member(member) }.compact
    end
    members
  end

  def self.valid_member(member)
    member["presence"] == "active" && member["is_bot"] == false
  end
end
