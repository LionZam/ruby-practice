describe Assessment do
  describe "#score" do
    def score_for(impact, likelihood)
      risk = instance_double(Risk, impact: impact, likelihood: likelihood)
      scale = instance_double(Scale, impacts: [1, 2, 3], likelihoods: [4, 5, 6])

      described_class.new(risk, scale).score
    end

    expect(score_for(2, 6)).to eq(6)

    context "when values out of index" do
      expect(score_for(0, 0)).to eq(1)
    end
  end
end
