require 'rails_helper'
require "#{Rails.root}/lib/classification_migrator"

RSpec.describe ClassificationMigrator do
  let(:user) { FactoryBot.create(:user) }
  let(:payee) { FactoryBot.create(:payee, user: user) }
  let(:family_member) { FactoryBot.create(:family_member, user: user) }

  before do
    @treatment_cost = Classification.create(name: '治療費')
    @medicine_cost = Classification.create(name: '医薬品費')
    @travel_cost = Classification.create(name: '交通費')
  end

  it do
    medical_bill_1 =
      MedicalBill.create(
        day: '2020-01-01',
        classification: '治療費',
        cost: 100,
        user: user,
        family_member: family_member,
        payee: payee
      )
    medical_bill_2 =
      MedicalBill.create(
        day: '2020-01-01',
        classification: '交通費',
        cost: 100,
        user: user,
        family_member: family_member,
        payee: payee
      )
    medical_bill_3 =
      MedicalBill.create(
        day: '2020-01-01',
        classification: '医薬品費',
        cost: 100,
        user: user,
        family_member: family_member,
        payee: payee
      )

    expect {
      ClassificationMigrator.execute
    }.to change {
      medical_bill_1.reload.classification_id
    }.from(nil).to(@treatment_cost.id).and change {
      medical_bill_2.reload.classification_id
    }.from(nil).to(@travel_cost.id).and change {
      medical_bill_3.reload.classification_id
    }.from(nil).to(@medicine_cost.id)
  end

  it do
    FactoryBot.create(:medical_bill, classification: 'あああ')

    expect { ClassificationMigrator.execute }.to raise_error UnknownClassificationError
  end

  it do
    20.times do
      MedicalBill.create(
        day: '2020-01-01',
        classification: '治療費',
        cost: 100,
        user: user,
        family_member: family_member,
        payee: payee
      )
    end

    expect(ClassificationMigrator.classification_id_nil_count).to eq 20
  end

  it do
    20.times do
      MedicalBill.create(
        day: '2020-01-01',
        classification: '治療費',
        cost: 100,
        user: user,
        family_member: family_member,
        payee: payee
      )
    end

    ClassificationMigrator.execute

    expect(ClassificationMigrator.classification_id_nil_count).to eq 0
  end
end
