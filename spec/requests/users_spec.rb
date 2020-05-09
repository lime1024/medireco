require 'rails_helper'

RSpec.describe 'User', type: :request do
  let(:user) { FactoryBot.create(:user, name: 'きんめだい') }

  it 'ユーザを登録できること' do
    expect {
      post users_path, params: {
        user: {
          name: 'しゃけ',
          email: 'shake@example.com',
          password: 'password'
        }
      }
    }.to change(User, :count).by(1)
    expect(response).to redirect_to(medical_bills_path)
  end

  context 'ログインしている場合' do
    before do
      login(user)
    end

    it 'ユーザを変更できること' do
      expect {
        patch user_path(user), params: {
          user: {
            name: 'まぐろ'
          }
        }
      }.to change { user.reload.name }.from('きんめだい').to('まぐろ')
      expect(response).to redirect_to(user_path(user))
    end

    it 'ユーザを削除できること' do
      expect {
        delete user_path(user)
      }.to change(User, :count).by(-1)
      expect(response).to redirect_to(root_path)
    end
  end

  context 'ログインしていない場合' do
    it do
      expect {
        delete user_path(user), params: {
          user: {
            name: 'まぐろ'
          }
        }
      }.not_to change { User.count }
      expect(response).to redirect_to(root_path)
    end
  end
end
