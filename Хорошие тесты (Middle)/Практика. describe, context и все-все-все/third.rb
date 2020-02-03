describe ControlTest do
  subject(:control_test) { build(:control_test) }

  context "#as_json" do
    let(:control_test_json) { control_test.as_json(control_test: true) }

    it "has all keys" do
      expect(control_test_json).to have_keys ["sample_size", "control_type", "test_method", "test_steps"]
    end
  end
end

RSpec::Matchers.define :have_keys do |expected|
  match do |actual|
    expected.each do |expected_key|
      actual.to have_key expected_key
    end
  end
end
