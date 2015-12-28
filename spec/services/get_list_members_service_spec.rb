require "rails_helper"

describe GetListMembersService do
  it "returns array of usernames" do
    VCR.use_cassette("slack_members") do
      expect(described_class.call).to eq(%w(billy cuongvu linhvn09 tangnv))
    end
  end
end
