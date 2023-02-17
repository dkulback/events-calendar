FactoryBot.define do
  factory :user do
    name { 'First_Name' }
    email { 'fist_name@email.com' }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
