require "spec_helper"
 
shared_context "when user signed in" do
  let(:current_relationship) { create(:relationship) }
  let(:current_user) { relationship.user }
  let(:current_account) { relationship.account }
  
  background do
    subdomain current_account.sub_domain
    login_as current_user
  end
end

feature "Create Entity Type" do
  NEW_ENTITY_TITLE = "The Game Has Changed"
  let(:new_entity_form) { find("#new_entity_form") }
  
  include_context "when user signed in"

  background do
    current_relationship.make_admin

    visit entity_types_path
  end

  def have_entity(title, options = {})
    have_css("#entity_types-table td", options.merge(text: NEW_ENTITY_TITLE))
  end

  scenario "Admin adds new entity type (category)" do
    click_link "New Category"

    new_entity_form.fill_in "Title", with: NEW_ENTITY_TITLE
    click_button "Save"
 
    expect(page).to have_entity(NEW_ENTITY_TITLE)
  end
end