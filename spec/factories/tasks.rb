FactoryBot.define do
  factory :task do
    sequence(:title) { |n| "Task #{n}" }
    size 3
    completed_at nil

    trait :small do
      size 1
    end

    trait :large do
      size 4
    end

    trait :soon do
      completed_at { 1.day.from_now }
    end

    trait :later do
      completed_at { 1.month.from_now }
    end

    trait :newly_complete do
      completed_at { 1.day.ago }
    end

    trait :long_complete do
      completed_at { 6.months.ago }
    end

    factory :trivial, class: Task, traits: %i[small later]
    factory :panic, class: Task, traits: %i[large soon]
    # Or
    # factory :trivial do
    #   small
    #   later
    # end
    # factory :panic do
    #   large
    #   soon
    # end
  end
end
