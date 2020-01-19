describe User do
  describe "#date_format" do
    let(:user) { described_class.new }

    it "has date_format if parent not presence" do
      expect { user.date_format }.to eq "%d.%m.%Y"
    end
  end
end