require "spec_helper"
 
feature "Audit To-Do List" do
  include_context "when user signed in"

  let(:audit) { create(:audit, account: account) }
  let!(:todo) { create(:todo, target: audit) }
  let!(:another_todo) { create(:todo, target: audit) }
  let(:modal_box) { page.find("#modal-box") }

  background do
    create(:project_role, audit: audit, role: ProjectRole::MANAGER, relationship: relationship) }

    visit audit_todos_path(audit)
  end

  def todo(id)
    page.find("#todo_#{id}")
  end
  
  scenario "Correctly display to-dos after update-delete from modal", js: true do
    todo(todo.id).click_button("Edit")
    modal_box.click_button("Save")

    expect(page).to have_content("Todo successfully edited")
 
    modal_box.click_button("Delete")
    modal_box.click_button("Confirm")

    expect(page).to have_content("Todo successfully deleted")
    expect(page).not_to have(modal_box)
    
    expect(page).not_to have_content("No to-dos have been added in this project yet")
    expect(page).to have_content(another_todo.description)
  end
end