describe Project do
  describe "#as_json" do
    subject { build(:project).as_json }
 
    it "has required keys" do
      is_expected.to be_a_project_json_representation
    end
  end
 
  describe "defaults" do
    subject { build(:project) }
 
    it "should be pre-populated" do
      is_expected.to be_a_project_representation
    end
  end
end

RSpec::Matchers.define :be_a_project_json_representation do
  match do |actual|
    expect(actual).to have_key("custom")
    expect(actual).to have_key("hours")
    expect(actual).to have_key("template")
  end
end

RSpec::Matchers.define :be_a_project_representation do
  match do |actual|
    expect(actual.post_types).to be_many
    expect(actual.hours).to eq 0
    expect(actual.template).to "default"
  end
end