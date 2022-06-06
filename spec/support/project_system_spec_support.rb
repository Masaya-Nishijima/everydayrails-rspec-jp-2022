module TypeTestProject
  def type_test_project
    fill_in "Name", with: "Test Project"
    fill_in "Description", with: "Trying out Capybara"
  end
end

RSpec.configure do |config|
  config.include TypeTestProject
end
