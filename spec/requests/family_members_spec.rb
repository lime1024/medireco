require 'rails_helper'

RSpec.describe 'FamilyMember', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let!(:family_member) { FactoryBot.create(:family_member, name: 'しゃけ', user: user) }

  context 'ログインしている場合' do
    before do
      login(user)
    end

    it '家族を登録できること' do
      expect {
        post user_family_members_path(user), params: {
          family_member: {
            name: 'かんぱち'
          }
        }
      }.to change(FamilyMember, :count).by(1)
      expect(response).to redirect_to(user_family_members_path(user))
    end

    it '家族を変更できること' do
      expect {
        patch user_family_member_path(user, family_member), params: {
          family_member: {
            name: 'のどぐろ'
          }
        }
      }.to change { family_member.reload.name }.from('しゃけ').to('のどぐろ')
      expect(response).to redirect_to(user_family_members_path(user))
    end

    it '家族を削除できること' do
      expect {
        delete user_family_member_path(user, family_member)
      }.to change(FamilyMember, :count).by(-1)
      expect(response).to redirect_to(user_family_members_path(user))
    end
  end

  context 'ログインしていない場合' do
    it do
      expect {
        post user_family_members_path(user), params: {
          family_member: {
            name: 'めばち'
          }
        }
      }.not_to change { FamilyMember.count }
      expect(response).to redirect_to(login_path)
    end
  end
end
