require 'rails_helper'

describe 'medical_bill', type: :model do
  context 'select_year 同一年が複数あったとき' do
    before do
      FactoryBot.create(:medical_bill, day: Date.new(2019, 01, 01))
      FactoryBot.create(:medical_bill, day: Date.new(2019, 02, 02))
      FactoryBot.create(:medical_bill, day: Date.new(2019, 03, 03))
    end

    it '返り値が重複しない' do
      expect(MedicalBill.select_year).to eq [2019]
    end
  end

  context 'select_year 異なる年が複数あったとき' do
    before do
      FactoryBot.create(:medical_bill, day: Date.new(2019, 01, 01))
      FactoryBot.create(:medical_bill, day: Date.new(2018, 02, 02))
      FactoryBot.create(:medical_bill, day: Date.new(2017, 03, 03))
    end

    it '全ての異なる年が返ってくる' do
      expect(MedicalBill.select_year).to eq [2019, 2018, 2017]
    end
  end

  context 'summarized_output 同一支払先に複数回支払ったとき' do
    before do
      FactoryBot.create(:medical_bill, day: Date.new(2019, 01, 01), cost: 300)
      FactoryBot.create(:medical_bill, day: Date.new(2018, 02, 02), cost: 500)
      FactoryBot.create(:medical_bill, day: Date.new(2017, 03, 03), cost: 200)
    end

    it '支払った金額が合算される' do
      expect(MedicalBill.summarized_output).to eq ["しゃけ", "おさかな病院", "治療費"]=>1000
    end
  end

  context 'this_year_total_cost 今年に支払いがあったとき' do
    before do
      FactoryBot.create(:medical_bill, day: Date.today, cost: 300)
      FactoryBot.create(:medical_bill, day: Date.today, cost: 500)
      FactoryBot.create(:medical_bill, day: Date.new(2017, 03, 03), cost: 200)
    end

    it '今年の支払額が合算される' do
      expect(MedicalBill.this_year_total_cost).to eq 800
    end
  end

  context '医療費登録をしたとき' do
    it 'can_not_set_future_date 未来日なら登録できない' do
      medical_bill = MedicalBill.new(day: Date.tomorrow, classification: "治療費", cost: 100)
      expect(medical_bill).to_not be_valid
    end

    it 'can_not_set_below_zero_yen 0 円なら登録できない' do
      medical_bill = MedicalBill.new(day: Date.new(2019, 01, 01), classification: "治療費", cost: 0)
      expect(medical_bill).to_not be_valid
    end

    it 'can_not_set_below_zero_yen 0 円以下なら登録できない' do
      medical_bill = MedicalBill.new(day: Date.new(2019, 01, 01), classification: "治療費", cost: -100)
      expect(medical_bill).to_not be_valid
    end
  end
end
