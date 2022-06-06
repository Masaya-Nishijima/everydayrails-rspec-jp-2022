require 'rails_helper'

RSpec.describe "Projects", type: :system do
  scenario "user creates a new project" do
    user = FactoryBot.create(:user)
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
        expect(page).to have_content "Test Project"
        expect(page).to have_content "Owner: #{user.name}"
      end
    }.to change(user.projects, :count).by(1)
  end

  scenario "ユーザーがプロジェクトを編集する" do
    user = FactoryBot.create(:user)
    project = FactoryBot.create(:project ,owner: user)
    # using our custom login helper:
    # sign_in_as user
    # or the one provided by Devise:
    sign_in user

    visit root_path # refactor: 直接`project`へアクセスしたいが project_pathではアクセスできなかった。
    click_link project.name # refactor: 同上

    expect {
      click_link "Edit"
      type_test_project
      click_button "Update Project"

      aggregate_failures do
        expect(page).to have_content "Project was successfully updated"
        expect(page).to have_content "Test Project"
        expect(page).to have_content "Owner: #{user.name}"
      end
    }.to change(user.projects, :count).by(0)
  end
end
