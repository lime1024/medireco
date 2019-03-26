FactoryBot.define do
  factory :family_member do
    name { 'しゃけ' }
    association :user
  end
end
