require 'rails_helper'

RSpec.describe MedicalBill, type: :model do
  describe '.select_year' do
    context '同一年が複数ある場合' do
      it '返り値が重複しないこと' do
        FactoryBot.create(:medical_bill, day: Date.new(2019, 01, 01))
        FactoryBot.create(:medical_bill, day: Date.new(2019, 02, 02))
        FactoryBot.create(:medical_bill, day: Date.new(2019, 03, 03))

        expect(described_class.select_year).to eq [2019]
      end
    end

    context '異なる年が複数ある場合' do
      it '全ての異なる年が返ってくること' do
        FactoryBot.create(:medical_bill, day: Date.new(2019, 01, 01))
        FactoryBot.create(:medical_bill, day: Date.new(2017, 03, 03))
        FactoryBot.create(:medical_bill, day: Date.new(2018, 02, 02))

        expect(described_class.select_year).to match_array([2019, 2018, 2017])
      end
    end
  end

  describe '.summarized_output' do
    context '同一支払先に複数回支払った場合' do
      it '支払った金額が合算されること' do
        FactoryBot.create(:medical_bill, day: Date.new(2019, 01, 01), cost: 300)
        FactoryBot.create(:medical_bill, day: Date.new(2018, 02, 02), cost: 500)
        FactoryBot.create(:medical_bill, day: Date.new(2017, 03, 03), cost: 200)

        expect(described_class.summarized_output.values).to eq [1000]
      end
    end
  end

  describe '.this_year_total_cost' do
    context '今年に支払いがあった場合' do
      it '支払額が合算されること' do
        FactoryBot.create(:medical_bill, day: Date.today, cost: 300)
        FactoryBot.create(:medical_bill, day: Date.today, cost: 500)
        FactoryBot.create(:medical_bill, day: Date.new(2017, 03, 03), cost: 200)

        expect(described_class.this_year_total_cost).to eq 800
      end
    end
  end

  describe '#can_not_set_future_date' do
    it '未来日なら登録できないこと' do
      medical_bill = described_class.new(day: Date.tomorrow, cost: 100)
      expect(medical_bill).to_not be_valid
    end
  end
end
