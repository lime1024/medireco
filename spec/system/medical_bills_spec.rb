require 'rails_helper'

describe '医療費登録', type: :system do
  before do
    FactoryBot.create(:user, name: 'まぐろ', email: 'maguro@example.com', password: 'password')
    visit login_path
    fill_in 'メールアドレス', with: 'maguro@example.com'
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
  end

  context '医療費が登録されているとき' do
    before do
      visit new_medical_bill_path
      fill_in 'medical_bill[day]', with: '01-11-002011'
      select 'しゃけ', from: 'medical_bill[family_member_id]'
      select 'おさかな病院', from: 'medical_bill[payee_id]'
      select '治療費', from: 'medical_bill[classification]'
      fill_in '金額を入力', with: '111111'
      click_button '登録'
    end

    it '医療費を閲覧することができる' do
      expect(page).to have_content 'しゃけ'
      expect(page).to have_content 'おさかな病院'
    end

    it '新しく登録した出力年が選択できる' do
      visit new_medical_bill_path
      fill_in 'medical_bill[day]', with: '01-11-002011'
      select 'しゃけ', from: 'medical_bill[family_member_id]'
      select 'おさかな病院', from: 'medical_bill[payee_id]'
      select '治療費', from: 'medical_bill[classification]'
      fill_in '金額を入力', with: '111111'
      click_button '登録'
      select '2011', from: 'year'
    end
  end
end
