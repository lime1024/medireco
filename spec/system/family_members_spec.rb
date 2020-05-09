require 'rails_helper'

describe '家族の登録', type: :system do
  let(:user) { FactoryBot.create(:user, name: 'まぐろ', email: 'maguro@example.com', password: 'password') }

  before do
    visit login_path
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: user.password
    click_button 'ログイン'
    visit user_family_members_path(user)
  end

  it '家族が閲覧できる' do
    family_member = FactoryBot.create(:family_member, name: 'しゃけ', user: user)
    visit current_path
    expect(page).to have_content family_member.name
  end
end
