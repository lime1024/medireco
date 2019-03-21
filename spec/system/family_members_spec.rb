require 'rails_helper'

describe '家族の登録', type: :system do
  before do
    FactoryBot.create(:user)
    visit login_path
    fill_in 'メールアドレス', with: 'maguro@example.com'
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
  end

  it '家族が登録できる' do
    visit new_user_family_member_path(user_id: 1)
    fill_in '家族の名前', with: 'まぐろ'
    click_button '登録'
    expect(page).to have_content 'まぐろ を登録しました'
  end

  context '家族が登録されているとき' do
    before do
      visit new_user_family_member_path(user_id: 1)
      fill_in '家族の名前', with: 'まぐろ'
      click_button '登録'
    end

    it '家族が閲覧できる' do
      expect(page).to have_content 'まぐろ' 
    end

    it '家族が変更できる' do
      click_link '編集'
      fill_in '家族の名前', with: 'のどぐろ'
      click_button '登録'
      expect(page).to have_content 'のどぐろ を更新しました'
    end

    it '家族が削除できる' do
      click_link '削除'
      expect(page).to have_content 'まぐろ を削除しました'
    end
  end
end
