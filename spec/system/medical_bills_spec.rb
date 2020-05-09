require 'rails_helper'

RSpec.describe '医療費登録', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:payee) { FactoryBot.create(:payee, user: user) }
  let(:family_member) { FactoryBot.create(:family_member, user: user) }
  let!(:medical_bill) { FactoryBot.create(:medical_bill, user: user, family_member: family_member, payee: payee) }

  before do
    login(user)
  end

  it '医療費を閲覧することができる' do
    expect(page).to have_content payee.name
    expect(page).to have_content family_member.name
  end

  it '新しく登録した出力年が選択できる' do
    FactoryBot.create(:medical_bill, day: '2020-01-01', user: user, family_member: family_member, payee: payee)
    visit current_path
    expect(page).to have_select('year', options: ['出力年を選択', '2019', '2020'])
  end
end
