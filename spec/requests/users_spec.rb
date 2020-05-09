require 'rails_helper'

RSpec.describe 'User', type: :request do
  let(:user) { FactoryBot.create(:user) }

  it 'アカウント登録ができる' do
    expect {
      post users_path, params: {
        user: {
          name: 'しゃけ',
          email: 'shake@example.com',
          password: 'password'
        }
      }
    }.to change(User, :count).by(1)
  end

  context 'ログインしている場合' do
    before do
      login(user)
    end

    it 'アカウントを変更できる' do
      patch user_path(user), params: {
        user: {
          name: 'まぐろ'
        }
      }
      expect(response).to redirect_to(user_path(user))
      expect(User.find(user.id).name).to eq 'まぐろ'
    end

    it 'アカウントを削除できる' do
      expect {
        delete user_path(user)
      }.to change(User, :count).by(-1)
    end
  end

  context 'ログインしていない場合' do
    it do
      delete user_path(user), params: {
        user: {
          name: 'まぐろ'
        }
      }
      expect(response).to redirect_to(root_path)
    end
  end
end
