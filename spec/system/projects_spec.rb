require 'rails_helper'

RSpec.describe "Projects", type: :system do
  let(:user){FactoryBot.create(:user)}
  scenario "user creates a new project" do
    # using our custom login helper:
    # sign_in_as user
    # or the one provided by Devise:
    sign_in user

    visit root_path

    expect {
      click_link "New Project"
      type_test_project
      click_button "Create Project"

      aggregate_failures do
        expect(page).to have_content "Project was successfully created"
        expect(page).to have_content "Typed title"
        expect(page).to have_content "Owner: #{user.name}"
      end
    }.to change(user.projects, :count).by(1)
  end

  scenario "ユーザーがプロジェクトを編集する" do
    project = FactoryBot.create(:project ,owner: user, name: "Before Title")
    # using our custom login helper:
    # sign_in_as user
    # or the one provided by Devise:
    sign_in user

    visit project_path(project)

    expect {
      click_link "Edit"
      type_test_project
      click_button "Update Project"

      aggregate_failures do
        expect(page).to have_content "Project was successfully updated"
        expect(page).to have_content "Typed title"
        expect(page).to have_content "Owner: #{user.name}"
      end
    }.to change(user.projects, :count).by(0)
  end
end
