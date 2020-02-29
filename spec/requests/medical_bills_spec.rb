require 'rails_helper'

RSpec.describe '医療費の登録', type: :request do
  let!(:user) { FactoryBot.create(:user, name: 'まぐろ', email: 'maguro@example.com', password: 'password') }
  let!(:payee) { FactoryBot.create(:payee, name: 'おさかな病院', user: user) }

  context 'ログインしているとき' do
    before do
      login(user)
    end

    it '医療費の登録ができる' do
      post medical_bills_path, params: {
        medical_bill: {
          day: '2011-01-11',
          family_member_id: user.family_members.first,
          payee_id: payee.id,
          classification: '治療費',
          cost: '111111'
        }
      }
    end
  end
end
