module TypeTestProject
  def type_test_project
    fill_in "Name", with: "Typed title"
    fill_in "Description", with: "Trying out Capybara"
  end
end

RSpec.configure do |config|
  config.include TypeTestProject
end
