describe Project do
  describe "#completion_percentage=" do
    subject(:project) { build_stubbed :project }

    context "when percentage more than 100" do
      it { project.completion_percentage(101).to eq(100) }
    end

    context "when percentage less than 100" do
      it { project.completion_percentage(99).to eq(99) }
    end

    context "when percentage less than 0" do
      it { project.completion_percentage(-1).to eq(0) }
    end

    context "when percentage eq 0" do
      it { project.completion_percentage(0).to eq(0) }
    end
    
    context "when percentage eq 100" do
      it { project.completion_percentage(100).to eq(100) }
    end
  end
end
