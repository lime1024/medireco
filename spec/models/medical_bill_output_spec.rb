require 'rails_helper'

RSpec.describe MedicalBillOutput, type: :model do
  describe '#as_xlsx' do
    it do
      user = FactoryBot.create(:user)
      FactoryBot.create(:family_member, user: user)
      FactoryBot.create(:payee, user: user)
      FactoryBot.create(:medical_bill, day: Date.new(2019, 01, 01), cost: 100, user: user)

      workbook = described_class.new(user: user, year: 2019).as_xlsx
      sheet = workbook.first

      expect(workbook).to be_a RubyXL::Workbook
      expect(sheet[2][2].value).to eq 100
      expect(sheet[8][0].value).to eq 1
      expect(sheet[8][1].value).to eq user.family_members.first.name
      expect(sheet[8][2].value).to eq user.payees.first.name
      expect(sheet[8][7].value).to eq 100
      expect(sheet[8][3].value).to eq '該当する'
    end
  end
end
