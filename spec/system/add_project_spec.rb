require "rails_helper"

RSpec.describe "adding a project", type: :system do
  it "allows a user to create aproject with tasks" do
    visit new_project_path
    fill_in "Name", with: "Project Runway"
    fill_in "Tasks", with: "Choose Fabric:3\nMake it Work:5"
    click_on "Create Project"
    visit projects_path
    @project = Project.find_by(name: "Project Runway")

    # expect(page).to have have_content("Project Runway")

    expect(page).to have_selector(
      "#project_#{@project.id} .name", text: "Project Runway")
    expect(page).to have_selector(
      "#project_#{@project.id} .total-size", text: "8")
  end

  it "does not allow a user to create a project without a name" do
    visit new_project_path
    fill_in "Name", with: ""
    fill_in "Tasks", with: "Choose Fabric:3\nMake it Work:5"
    click_on("Create Project")

    expect(page).to have_selector(".new_project")
  end

  # it "pending test", :pending do
  # end
  # it "pending test 2" do
  #   pending "not implemented yet"
  # end
  # xit "not run test" or xdescribe or it "not run", :skip


  it "behaves correctly in the face of surprising database failure" do
    workflow = instance_spy(CreatesProject,
      success?: false, project: Project.new)
    allow(CreatesProject).to receive(:new)
      .with(name: "Real Name",
            task_string: "Choose Fabric:3\r\nMake it Work:5")
      .and_return(workflow)

    visit new_project_path
    fill_in "Name", with: "Real Name"
    fill_in "Tasks", with: "Choose Fabric:3\nMake it Work:5"
    click_on("Create Project")
    expect(page).to have_selector(".new_project")
  end
end
