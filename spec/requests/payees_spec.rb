require 'rails_helper'

RSpec.describe '支払先の登録', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let!(:payee) { FactoryBot.create(:payee, user: user) }

  context 'ログインしている場合' do
    before do
      login(user)
    end

    it '支払先を登録できる' do
      expect {
        post user_payees_path(user), params: {
          payee: {
            name: 'かわざかな薬局'
          }
        }
      }.to change(Payee, :count).by(1)
    end

    it '支払先を変更できる' do
      patch user_payee_path(user, payee), params: {
        payee: {
          name: 'かわざかな薬局'
        }
      }
      expect(response).to redirect_to(user_payees_path(user))
      expect(Payee.find(payee.id).name).to eq 'かわざかな薬局'
    end

    it '支払先を削除できる' do
      expect {
        delete user_payee_path(user, payee)
      }.to change(Payee, :count).by(-1)
    end
  end

  context 'ログインしていない場合' do
    it do
      post user_payees_path(user), params: {
        payee: {
          name: 'かわざかな薬局'
        }
      }
      expect(response).to redirect_to(login_path)
    end
  end
end
