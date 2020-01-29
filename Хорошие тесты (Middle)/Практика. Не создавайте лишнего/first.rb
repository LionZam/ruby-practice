describe Assessment do
  subject { described_class.new(risk, scale) }
  let(:risk) { instance_double(Risk, impact: 2, likelihood: 6) }
  let(:scale) { instance_double(Scale, impacts: [1, 2, 3], likelihoods: [4, 5, 6]) }

  describe "#score" do
    expect(subject.score).to eq(6)
  end
end