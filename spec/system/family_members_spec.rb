require 'rails_helper'

describe '家族の登録', type: :system do
  let!(:user) { FactoryBot.create(:user, name: 'まぐろ', email: 'maguro@example.com', password: 'password') }

  before do
    visit login_path
    fill_in 'メールアドレス', with: 'maguro@example.com'
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
  end

  it '家族が登録できる' do
    click_link 'ユーザ情報'
    click_link '家族の一覧'
    click_link '新規登録'
    fill_in 'family_member[name]', with: 'しゃけ'
    click_button '登録'
    expect(page).to have_content 'しゃけ を登録しました'
  end

  context '家族が登録されているとき' do
    before do
      FactoryBot.create(:family_member, name: 'しゃけ', user: user)
      click_link 'ユーザ情報'
      click_link '家族の一覧'
    end

    it '家族が閲覧できる' do
      expect(page).to have_content 'しゃけ'
    end

    it '家族が変更できる' do
      click_link '編集'
      fill_in 'family_member[name]', with: 'のどぐろ'
      click_button '登録'
      expect(page).to have_content 'のどぐろ を更新しました'
    end

    it '家族が削除できる' do
      click_link '削除'
      expect(page).to have_content 'しゃけ を削除しました'
    end
  end
end
