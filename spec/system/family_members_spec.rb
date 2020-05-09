require 'rails_helper'

RSpec.describe 'FamilyMember', type: :system do
  let(:user) { FactoryBot.create(:user, name: 'まぐろ') }

  before do
    login(user)
    visit user_family_members_path(user)
  end

  it '家族が閲覧できること' do
    family_member = FactoryBot.create(:family_member, name: 'しゃけ', user: user)
    visit current_path
    expect(page).to have_content family_member.name
  end
end
