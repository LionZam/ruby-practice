describe Api::V1::ExceptionsController do
  let(:exceptions_controller) { described_class.new }
  let(:user) { build: user, role: role }
  let(:project) { build: project, :with_exceptions }
  let(:user_exception) { build: exception, user: :user }

  before do
    allow(exceptions_controller).to receive("load_project").and_return(project)
    project.exceptions.push(user_exception)
  end

  describe "#index" do
    subject(:index) { exceptions_controller.index }

    before do
      allow(ApplicationController).to receive("current_user").and_return(user)
    end

    context "when user is admin" do
      let(:role) { "admin" }

      it "returns all exceptions" do
        expect(index.size).to eq(project.exceptions.size)
      end
    end

    context "when user is a user" do
      let(:role) { "user" }

      it "returns available for user exceptions" do
        expect(index.size).to eq(1)
      end
    end
  end
end
