FactoryBot.define do
  factory :user do
    id { 1 }
    email { 'test@mail.ru' }
    password { 'serg123' }
    first_name { 'John' }
    last_name  { 'Doe' }
  end
end
