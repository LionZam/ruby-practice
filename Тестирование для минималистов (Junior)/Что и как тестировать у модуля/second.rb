describe Objective do
  describe "#locked" do
    let(:objective) { described_class.new }

    it "not locked by default" do
      expect { objective.locked? }.to eq false
    end
  end

  describe "#release_lock" do
    let(:objective) { described_class.new }

    it "assign attributes" do
      expect { assessment.release_lock }.to change { objective.locked_by }
    end
  end
end