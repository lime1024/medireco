require 'rails_helper'

RSpec.describe 'Payee', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let!(:payee) { FactoryBot.create(:payee, name: 'おさかな病院',user: user) }

  context 'ログインしている場合' do
    before do
      login(user)
    end

    it '支払先を登録できること' do
      expect {
        post user_payees_path(user), params: {
          payee: {
            name: 'かわざかな薬局'
          }
        }
      }.to change(Payee, :count).by(1)
      expect(response).to redirect_to(user_payees_path)
    end

    it '支払先を変更できること' do
      expect {
        patch user_payee_path(user, payee), params: {
          payee: {
            name: 'かわざかな薬局'
          }
        }
      }.to change { payee.reload.name }.from('おさかな病院').to('かわざかな薬局')
      expect(response).to redirect_to(user_payees_path(user))
    end

    it '支払先を削除できること' do
      expect {
        delete user_payee_path(user, payee)
      }.to change(Payee, :count).by(-1)
      expect(response).to redirect_to(user_payees_path(user))
    end
  end

  context 'ログインしていない場合' do
    it do
      expect {
        post user_payees_path(user), params: {
          payee: {
            name: 'かわざかな薬局'
          }
        }
      }.not_to change { Payee.count }
      expect(response).to redirect_to(login_path)
    end
  end
end
