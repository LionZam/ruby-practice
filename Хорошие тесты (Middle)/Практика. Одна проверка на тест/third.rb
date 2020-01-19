describe ProjectType do
  describe "serialized fields" do
    let(:project_type) { build(:project_type) }
    let(:empty_arrays) { 
      {
        project_types: [],
        severity_values: [],
        scopes: []
      }
    }
    before do
      project_type.project_types = nil
      project_type.severity_values = nil
      project_type.scopes = nil
      
      project_type.save
      project_type.reload
    end

    it "converts nils to empty arrays" do
      expect(project_type).to be_project_type_representation(empty_arrays)
    end
  end
end

RSpec::Matchers.define :be_project_type_representation do |values|
  match do |actual|
    expect(project_type.project_types).to eq values[:project_types]
    expect(project_type.severity_values).to eq values[:severity_values]
    expect(project_type.scopes).to eq values[:scopes]
  end
end