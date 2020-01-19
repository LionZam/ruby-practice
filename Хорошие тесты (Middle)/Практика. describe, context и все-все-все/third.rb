describe ControlTest do
  subject(:control_test) { build(:control_test) }

  context "#as_json" do
    let(:control_test_json) { control_test.as_json(control_test: true) }
     
    it "has all keys" do
      control_test_json.to have_key "sample_size"
      control_test_json.to have_key "control_type"
      control_test_json.to have_key "test_method"
      control_test_json.to have_key "test_steps" 
    end
  end
end