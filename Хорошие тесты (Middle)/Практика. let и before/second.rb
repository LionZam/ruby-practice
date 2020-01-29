describe ProjectRole do
  describe "#project_admin?" do
    context "when user has global admin role" do
      before { create(:admin_role, user: user) }

      it "assumes that user also has project admin role" do
        expect(project_role).to be_project_admin
      end
    end
  end
end
