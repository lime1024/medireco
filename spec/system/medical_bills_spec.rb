require 'rails_helper'

describe '医療費登録', type: :system do
  before do
    FactoryBot.create(:user)
    visit login_path
      fill_in 'メールアドレス', with: 'maguro@example.com'
      fill_in 'パスワード', with: 'password'
      click_button 'ログイン'

      visit new_user_family_member_path(user_id: 1)
      fill_in '家族の名前', with: 'まぐろ'
      click_button '登録'

      visit new_user_payee_path(user_id: 1)
      fill_in '支払先の名前', with: 'おさかな病院'
      click_button '登録'
  end

  it '医療費が登録できる' do
    visit new_medical_bill_path
    fill_in 'medical_bill[day]', with: '01-11-002011'
    select 'まぐろ', from: 'medical_bill[family_member_id]'
    select 'おさかな病院', from: 'medical_bill[payee_id]'
    select '治療費', from: 'medical_bill[classification]'
    fill_in '金額を入力', with: '111111'
    click_button '登録'
    expect(page).to have_content '2011-01-11 まぐろの治療費を登録しました'
  end

  context '医療費が登録されているとき' do
    before do
      visit new_medical_bill_path
      fill_in 'medical_bill[day]', with: '01-11-002011'
      select 'まぐろ', from: 'medical_bill[family_member_id]'
      select 'おさかな病院', from: 'medical_bill[payee_id]'
      select '治療費', from: 'medical_bill[classification]'
      fill_in '金額を入力', with: '111111'
      click_button '登録'
    end

    it '医療費を閲覧することができる' do
      expect(page).to have_content 'まぐろ'
      expect(page).to have_content 'おさかな病院'
    end

    it '医療費を編集することができる' do
      click_link '編集'
      select '交通費', from: 'medical_bill[classification]'
      fill_in '金額を入力', with: '123456'
      click_button '登録'
      expect(page).to have_content '2011-01-11 まぐろの交通費を更新しました'
    end

    it '医療費を削除することができる' do
      click_link '削除'
      expect(page).to have_content '2011-01-11 まぐろの治療費を削除しました' 
    end

    it '新しく登録した出力年が選択できる' do
      visit new_medical_bill_path
      fill_in 'medical_bill[day]', with: '01-11-002011'
      select 'まぐろ', from: 'medical_bill[family_member_id]'
      select 'おさかな病院', from: 'medical_bill[payee_id]'
      select '治療費', from: 'medical_bill[classification]'
      fill_in '金額を入力', with: '111111'
      click_button '登録'
      select '2011', from: 'year'
    end
  end
end
