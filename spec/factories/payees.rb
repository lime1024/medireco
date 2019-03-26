FactoryBot.define do
  factory :payee do
    name { 'おさかな病院' }
    association :user
  end
end
