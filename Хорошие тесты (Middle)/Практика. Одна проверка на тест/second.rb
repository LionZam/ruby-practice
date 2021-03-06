describe Account do
  descirbe ".create" do
    subject(:account) { build_stubbed(:account) }

    it "creates all defaults" do
      is_expected.to be_account_representation(params)
    end
  end
end

RSpec::Matchers.define :be_account_representation do |values|
  match do |actual|
    expect(actual.statuses.count).to eq 7
    expect(actual.statuses.map(&:system).uniq).to eq [true]
    expect(actual.priorities.count).to eq 4
    expect(actual.priorities.map(&:system).uniq).to eq [true]
    expect(actual.priorities.map(&:name).sort).to eq Priority::SYSTEM_PRIORITIES.map(&:to_s).sort
  end
end
