require "rails_helper"

RSpec.describe TaskMailer, type: :mailer do

  describe "task_complete_email" do
    let(:project) { create(:project) }
    let(:task) { create(
      :task, project: project, title: "Learn how to test mailers", size: 3) }

    it "renders the email" do
      expect(mail.subject).to eq("A task has been completed")
      expect(mail.to), eq(["monitor@tasks.com"])
      expect(mail.body.encoded).to match(/Learn how to test mailers/)
    end
  end
end
