require 'rails_helper'
require "#{Rails.root}/lib/classification_migrator"

RSpec.describe ClassificationMigrator do
  before do
    @treatment_cost = Classification.create(name: '治療費')
    @medicine_cost = Classification.create(name: '医薬品費')
    @travel_cost = Classification.create(name: '交通費')
  end

  it do
    medical_bill_1 = FactoryBot.create(:medical_bill, classification: '治療費')
    medical_bill_2 = FactoryBot.create(:medical_bill, classification: '交通費')
    medical_bill_3 = FactoryBot.create(:medical_bill, classification: '医薬品費')

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
end
