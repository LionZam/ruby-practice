describe Account do
  subject(:account) { build_stubbed :account }

  describe "#api_accessible" do
    subject(:api_accessible) { account.api_accessible }

    context "with enabled api access" do
      before do
        account.update_attribute(:api_accessible, true)
      end

      it { is_expected.to be_truthy }
    end

    context "with disabled api access" do
      before do
        account.update_attribute(:api_accessible, false)
      end

      it { is_expected.to be_falsey }
    end
  end
end
