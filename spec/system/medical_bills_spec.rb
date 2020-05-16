require 'rails_helper'

RSpec.describe 'MedicalBill', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:payee) { FactoryBot.create(:payee, user: user) }
  let(:family_member) { FactoryBot.create(:family_member, user: user) }
  let!(:medical_bill) { FactoryBot.create(:medical_bill, day: '2019-01-01', user: user, family_member: family_member, payee: payee) }

  before do
    login(user)
    visit medical_bills_path
  end

  it '医療費を閲覧することができること' do
    expect(page).to have_content payee.name
    expect(page).to have_content family_member.name
  end

  it '新しく登録した出力年が選択できること' do
    FactoryBot.create(:medical_bill, day: '2020-01-01', user: user, family_member: family_member, payee: payee)
    visit current_path
    expect(page).to have_select('year', options: ['出力年を選択', '2019', '2020'])
  end
end
