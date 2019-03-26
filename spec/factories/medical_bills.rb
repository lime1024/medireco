FactoryBot.define do
  factory :medical_bill do
    day { Date.new(2019, 01, 01) }
    classification { "治療費" }
    cost { 100 }
    association :user
    association :family_member
    association :payee
  end
end
