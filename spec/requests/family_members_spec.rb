require 'rails_helper'

RSpec.describe '家族の登録', type: :request do
  let!(:user) { FactoryBot.create(:user, name: 'まぐろ', email: 'maguro@example.com', password: 'password') }
  let!(:family_member) { FactoryBot.create(:family_member, name: 'しゃけ', user: user) }

  context '家族が登録されているとき' do
    it '家族を変更できる' do
      login(user)
      patch user_family_member_path(user, family_member), params: {
        family_member: {
          name: 'のどぐろ'
        }
      }
      expect(response).to redirect_to(user_family_members_path(user))
      expect(FamilyMember.find(family_member.id).name).to eq 'のどぐろ'
    end
  end
end
