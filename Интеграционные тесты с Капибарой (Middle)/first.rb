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

shared_examples "without deleted audit" do |audit_name|
  visit audits_path

  expect(page).to_not have_content(audit_name)
  
  visit audit_path(another_audit)
  
  expect(page).to have_content("Access Restricted")
end

feature "Audit Deletion" do
  include_context "when user signed in"

  let(:audit) { create(:audit, account: account) }
  let!(:project_role) { create(:project_role, audit: audit, role: ProjectRole::MANAGER, relationship: relationship) }
  
  scenario "delete audit" do
    visit audit_path(audit)
 
    within ".caution-zone" do
      click_link "Delete Project"
    end
 
    it_should_behave_like "without deleted audit", "My Audit 1"
    expect(page).to have_content("Project was scheduled for permanent deletion")
    expect(Audit.all).to_not include(audit)
  end
end