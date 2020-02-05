require "spec_helper"

shared_context "when user signed in" do
  let(:relationship) { create(:relationship) }
  let(:user) { relationship.user }
  let(:account) { relationship.account }

  background do
    subdomain account.sub_domain
    login_as user
  end
end

feature "Audit Deletion" do
  include_context "when user signed in"

  background do
    audit = create(:audit, account: account, name: "My Audit 1")
    deleted_audit = create(:audit, account: account, status: "delete", name: "Deleted Audit")

    create(:project_role, audit: audit, role: ProjectRole::MANAGER, relationship: relationship)
    create(:project_role, audit: deleted_audit, role: ProjectRole::MANAGER, relationship: relationship)

    visit audits_path
  end

  let(:delete_button) { page.find(".caution-zone") }

  scenario "Project manager deletes Audit" do
    expect(page).to_not have_content("Deleted Audit")
    expect(page).to have_content("My Audit 1")

    click_link "My Audit 1"
    caution_zone.click_buttom "Delete Audit"

    expect(path).to eql(audits_path)
    expect(page).to have_content("Project was scheduled for permanent deletion")
    expect(page).to_not have_content("My Audit 1")
  end
end
