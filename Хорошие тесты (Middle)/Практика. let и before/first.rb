describe AccountsController do
  describe "#index" do
    let(:active_accounts) { 3.times.reduce([]) {|array| array + create(:account)} }
    let(:pending_accounts) { 2.times.reduce([]) {|array| array + create(:pending_account)} }

    it "displays only active accounts" do
      get :index

      expect(assigns(:accounts)).to match_array(active_accounts)
    end
  end
end
