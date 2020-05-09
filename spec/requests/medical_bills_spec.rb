require 'rails_helper'

RSpec.describe '医療費の登録', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let!(:payee) { FactoryBot.create(:payee, user: user) }
  let!(:family_member) { FactoryBot.create(:family_member, user: user) }

  context 'ログインしている場合' do
    before do
      login(user)
    end

    it '医療費の登録ができること' do
      expect {
        post medical_bills_path, params: {
          medical_bill: {
            day: '2011-01-11',
            classification: '治療費',
            cost: '111111',
            user_id: user.id,
            family_member_id: family_member.id,
            payee_id: payee.id
          }
        }
      }.to change(MedicalBill, :count).by(1)
    end

    xit do
      post medical_bills_path
      expect(response).to redirect_to(medical_bills_path)
    end

    it '医療費が編集できること' do
      medical_bill = FactoryBot.create(:medical_bill, user: user, cost: 111111)
      expect {
        patch medical_bill_path(medical_bill.id), params: {
          medical_bill: {
            cost: '123456'
          }
        }
      }.to change{ medical_bill.reload.cost }.from(111111).to(123456)
    end

    it '医療費を削除できること' do
      medical_bill = FactoryBot.create(:medical_bill, user: user)
      expect {
        delete medical_bill_path(medical_bill.id)
      }.to change(MedicalBill, :count).by(-1)
    end
  end

  context 'ログインしていない場合' do
    it do
      post medical_bills_path, params: {
        medical_bill: {
          day: '2011-01-11',
          classification: '治療費',
          cost: '111111',
          user_id: user.id,
          family_member_id: family_member.id,
          payee_id: payee.id
        }
      }
      expect(response).to redirect_to(login_path)
    end
  end
end
