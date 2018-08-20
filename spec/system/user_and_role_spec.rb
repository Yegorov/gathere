require "rails_helper"

RSpec.describe "with users and roles" do
  def log_in_as(user)
    visit new_user_session_path
    fill_in("user_email", with: user.email)
    fill_in("user_password", with: user.password)
    click_button("Log in")
  end

  let(:user) { User.create(email: "test@example.com", password: "password") }
  let(:project) { create(:project, name: "Project Gutenberg") }

  it "allows a logged-in user to view the project index page" do
    project.roles.create(user: user)
    login_as(user)
    visit(project_path(project))
    expect(current_path).to eq(project_path(project))
  end

  it "does not allow a user to see the project page if not logged in" do
    login_as(user)
    visit(project_path(project))
    expect(current_path).not_to eq(project_path(project))
  end

  describe "index page" do
    let!(:my_project) { create(:project, name: "My Project") }
    let!(:not_my_project) { create(:project, name: "Not My Project") }

    it "allows users to see only projects that are visible" do
      my_project.roles.create(user: user)
      login_as(user)
      visit(projects_path)
      expect(page).to have_selector("#project_#{my_project.id}")
      expect(page).not_to have_selector("#project_#{not_my_project.id}")
    end
  end

  describe "visible projects" do
    let!(:project_1) { create(:project, name: "Project 1") }
    let!(:project_2) { create(:project, name: "Project 2") }

    it "allows a user to see their projects" do
      user.projects << project_1
      expect(user.visible_projects).to eq([project_1])
    end
    it "allows an admin to see all projects" do
      user.admin = true
      expect(user.visible_projects).to match_array(Project.all)
    end
    it "allows a user to see public projects" do
      user.projects << project_1
      project_2.update(public: true)
      expect(user.visible_projects).to match_array([project_1, project_2])
    end
    it "has no duplicates in project list" do
      user.projects << project_1
      project_1.update(public: true)
      expect(user.visible_projects).to match_array([project_1])
    end

  end
end
