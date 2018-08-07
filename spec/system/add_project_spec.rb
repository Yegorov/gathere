require "rails_helper"

RSpec.describe "adding a project", type: :system do
  it "allows a user to create aproject with tasks" do
    visit new_project_path
    fill_in "Name", with: "Project Runway"
    fill_in "Tasks", with: "Choose Fabric:3\nMake it Work:5"
    click_on "Create Project"
    visit projects_path
    expect(page).to have_content("Project Runway")
    expect(page).to have_content(8)
  end

  # it "pending test", :pending do
  # end
  # it "pending test 2" do
  #   pending "not implemented yet"
  # end
  # xit "not run test" or xdescribe or it "not run", :skip
end
