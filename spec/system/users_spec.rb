require 'rails_helper'

describe 'アカウント', type: :system do
  it 'アカウント登録ができる' do
    visit new_user_path
    fill_in '名前', with: 'まぐろ'
    fill_in 'メールアドレス', with: 'maguro@example.com'
    fill_in 'パスワード', with: 'password'
    fill_in 'パスワード(確認)', with: 'password'
    click_button '登録'
    expect(page).to have_content 'ユーザ まぐろ を登録しました'
  end

  context 'ユーザが登録されているとき' do
    before do
      FactoryBot.create(:user, name: 'まぐろ', email: 'maguro@example.com', password: 'password')
      visit login_path
      fill_in 'メールアドレス', with: 'maguro@example.com'
      fill_in 'パスワード', with: 'password'
      click_button 'ログイン'
    end

    it 'アカウントが閲覧できる' do
      click_link 'ユーザ情報'
      expect(page).to have_content 'まぐろ'
      expect(page).to have_content 'maguro@example.com'
    end

    it 'アカウントが編集できる' do
      click_link 'ユーザ情報'
      click_link '編集'
      fill_in '名前', with: 'しゃけ'
      fill_in 'メールアドレス', with: 'shake@example.com'
      fill_in 'パスワード', with: 'password'
      fill_in 'パスワード(確認)', with: 'password'
      click_button '登録'
      expect(page).to have_content 'ユーザ しゃけ を更新しました'
    end

    it 'アカウントが削除できる' do
      click_link 'ユーザ情報'
      click_link '退会'
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_content 'ユーザ まぐろ を削除しました'
    end
  end
end
