describe Project do
  let(:project) { build :project, completion_percentage: completion_percentage }

  describe "#completion_percentage=" do
    subject { project.completion_percentage }

    context "when percentage more than 0" do
      context "when percentage more than 100" do
        let(:completion_percentage { 101 }

        it { is_expected }.to eq(100)
      end
      context "when percentage less than 100" do
        let(:completion_percentage { 99 }

        it { is_expected }.to eq(99)
      end
      context "when percentage eq 100" do
        let(:completion_percentage { 100 }

        it { is_expected }.to eq(100)
      end
    end
    context "when percentage less than 0" do
      let(:completion_percentage { -1 }

        it { is_expected }.to eq(0)
    end
    context "when percentage eq 0" do
      let(:completion_percentage { 0 }

      it { is_expected }.to eq(0)
    end
  end
end