require 'rails_helper'

describe '支払先の登録', type: :system do
  let!(:user) { FactoryBot.create(:user, name: 'まぐろ', email: 'maguro@example.com', password: 'password') }

  before do
    visit login_path
    fill_in 'メールアドレス', with: 'maguro@example.com'
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
    visit user_payees_path(user)
  end

  it '支払先が閲覧できる' do
    payee = FactoryBot.create(:payee, name: 'おさかな病院', user: user)
    visit current_path
    expect(page).to have_content 'おさかな病院' 
  end
end
