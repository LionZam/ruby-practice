describe TimeEntry do
  describe ".create!" do
    let(:user) { create(:user) }
    let(:objective) { create(:objective) }
    let(:valid_attributes) {
      {
        date: Date.today,
        time: 9.99,
        client_delay: false,
        description: "description"
      } 
    }
    subject do 
      TimeEntry.create!(valid_attributes) do |te|
        te.user = user
        te.creator = user
        te.target = objective
      end
    end

    it "creates valid todo" do
      is_expected.to be_valid
    end
  end
end