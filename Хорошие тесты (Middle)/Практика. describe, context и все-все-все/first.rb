describe Account do
  describe "#api_accessible" do
    subject { described_class.new }

		context "with enabled api access" do
      account.update_attribute(:api_accessible, true)

			it { is_expected.api_accessible.should be_true }
		end
 
    context "with disabled api access" do
      account.update_attribute(:api_accessible, false)

			it { is_expected.api_accessible.should be_false }
		end
  end
end