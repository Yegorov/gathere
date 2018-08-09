FactoryBot.define do
  factory :project do
    name "Project Runway"
    # due_date 1.week.from_now
    due_date { Date.today - rand(50) }
    # slug { "#{name.downcase.gsub(" ", "_")}" }
  end
end

# FactoryBot.define do
#   factory :big_project, class: Project do
#     name "Big Project"
#   end
# end
