require 'rails_helper'

RSpec.describe 'User', type: :system do
  let(:user) { FactoryBot.create(:user) }

  before do
    login(user)
    visit user_path(user)
  end

  it 'アカウントが閲覧できる' do
    expect(page).to have_content user.name
    expect(page).to have_content user.email
  end
end
