FactoryBot.define do
  factory :user do
    email { "test#{rand(100)}@mail.ru" }
    password { 'test123' }
    first_name { 'test1' }
    last_name { 'test2' }
  end
end