require 'rails_helper'

RSpec.describe '家族の登録', type: :request do
  let(:user) { FactoryBot.create(:user, name: 'まぐろ', email: 'maguro@example.com', password: 'password') }
  let!(:family_member) { FactoryBot.create(:family_member, name: 'しゃけ', user: user) }

  context 'ログインしている場合' do
    before do
      login(user)
    end

    it '家族を登録できる' do
      expect {
        post user_family_members_path(user), params: {
          family_member: {
            name: 'かんぱち'
          }
        }
      }.to change(FamilyMember, :count).by(1)
    end

    it '家族を変更できる' do
      patch user_family_member_path(user, family_member), params: {
        family_member: {
          name: 'のどぐろ'
        }
      }
      expect(response).to redirect_to(user_family_members_path(user))
      expect(FamilyMember.find(family_member.id).name).to eq 'のどぐろ'
    end

    it '家族を削除できる' do
      expect {
        delete user_family_member_path(user, family_member)
      }.to change(FamilyMember, :count).by(-1)
    end
  end

  context 'ログインしていない場合' do
    it do
      post user_family_members_path(user), params: {
        family_member: {
          name: 'めばち'
        }
      }
      expect(response).to redirect_to(login_path)
    end
  end
end
