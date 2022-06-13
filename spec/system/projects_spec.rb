require 'rails_helper'

RSpec.describe "Projects", type: :system do
  before do
    @user = FactoryBot.create(:user)
    sign_in @user
  end
  context "プロジェクト作成" do
    scenario "user creates a new project" do
      visit root_path

      expect {
        click_link "New Project"
        fill_in "Name", with: "Test Project"
        fill_in "Description", with: "Trying out Capybara"
        click_button "Create Project"

        aggregate_failures do
          expect(page).to have_content "Project was successfully created"
          expect(page).to have_content "Test Project"
          expect(page).to have_content "Owner: #{@user.name}"
        end
      }.to change(@user.projects, :count).by(1)
    end
  end

  context "コンプリート機能の動作" do
    before do
      @project = FactoryBot.create(:project, owner: @user)
    end

    scenario "user completes a project" do
      visit project_path(@project)

      expect(page).to_not have_content "Completed"

      click_button "Complete"

      expect(@project.reload.completed?).to be true
      expect(page).to \
        have_content "Congratulations, this project is complete!"
      expect(page).to have_content "Completed"
      expect(page).to_not have_button "Complete"
    end

    scenario "コンプリート済みのプロジェクトを非表示にする" do
      visit root_path
      expect(page).to have_content @project.name

      visit project_path(@project)

      click_button "Complete"

      visit root_path
      expect(page).to_not have_content @project.name
      #一覧画面でリンクに打ち消し線を付ける。
    end

    scenario "完了済みもShowAllボタンを押されたら表示する" do
      visit project_path(@project)

      click_button "Complete"

      visit root_path

      click_link "ShowAll"
      expect(page).to have_content @project.name
    end
  end
end
