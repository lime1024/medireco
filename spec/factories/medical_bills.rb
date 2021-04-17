FactoryBot.define do
  factory :medical_bill do
    day { Date.new(2019, 01, 01) }
    cost { 100 }
    association :user
    association :family_member
    association :payee
    association :_classification, factory: :classification
  end
end
