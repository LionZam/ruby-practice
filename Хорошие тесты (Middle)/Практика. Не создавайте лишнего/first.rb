describe Assessment do
  def create_assessment(impact, likelihood)
    risk = instance_double(Risk, impact: impact, likelihood: likelihood)
    scale = instance_double(Scale, impacts: [1, 2, 3], likelihoods: [4, 5, 6])
    described_class.new(risk, scale).score
  end

  describe "#score" do
    expect(create_assessment(2, 6).score).to eq(6)

    context "when values out of index" do
      expect(create_assessment(0, 0).score).to eq(1)
    end
  end
end