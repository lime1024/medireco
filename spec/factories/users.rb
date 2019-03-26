FactoryBot.define do
  factory :user do
    name { 'さかな' }
    password { 'password' }

    sequence(:email) do |n|
      "sakana#{n}@example.com"
    end
  end
end
