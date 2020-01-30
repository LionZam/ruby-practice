describe TimeEntry do
  describe ".create!" do
    subject(:time_entry) { create_time_entry }

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

    def create_time_entry
      TimeEntry.create!(valid_attributes) do |te|
        te.user = user
        te.creator = user
        te.target = objective
      end
    end

    it { is_expected.to be_valid }
  end
end
