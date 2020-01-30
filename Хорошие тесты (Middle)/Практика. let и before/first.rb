describe AccountsController do
  describe "#index" do
    let(:active_accounts) { build_stubbed_list(:account) }
    let(:pending_accounts) { build_stubbed_list(:pending_account) }

    it "displays only active accounts" do
      get :index

      expect(assigns(:accounts)).to match_array(active_accounts)
    end
  end
end
