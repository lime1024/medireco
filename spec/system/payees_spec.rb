require 'rails_helper'

RSpec.describe 'Payee', type: :system do
  let(:user) { FactoryBot.create(:user) }

  before do
    login(user)
    visit user_payees_path(user)
  end

  it '支払先が閲覧できること' do
    payee = FactoryBot.create(:payee, name: 'おさかな病院', user: user)
    visit current_path
    expect(page).to have_content payee.name 
  end
end
