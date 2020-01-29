require "tasks/support/remove_invalid_accounts"

namespace :accounts do
  desc "Remove invalid accounts having no owner"
  task :remove_invalid => :environment do
    RemoveInvalidAccounts.new.perform
  end
end

describe "accounts" do
  describe "remove_invalid.rake" do
    subject { Rake::Task["accounts:remove_invalid"].invoke }

    it { is_expected }.to change(Account.invalid, :count).to(0)
    end
  end
end