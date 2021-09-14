FactoryBot.define do
  factory :user do
    email { "test#{rand(100)}@mail.ru" }
    password { 'test123' }
    first_name { 'test1' }
    last_name { 'test2' }
  end

  factory :task do
    association :user, factory: :user
    title { 'Test task title in devise' }
    description { 'Test task description in devise' }
  end
end
