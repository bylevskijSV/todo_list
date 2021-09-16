FactoryBot.define do
  factory :task do
    association :user, factory: :user
    title { 'Test task title in devise' }
    description { 'Test task description in devise' }
  end
end
