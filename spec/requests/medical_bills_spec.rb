require 'rails_helper'

RSpec.describe 'MedicalBill', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:payee) { FactoryBot.create(:payee, user: user) }
  let(:family_member) { FactoryBot.create(:family_member, user: user) }
  let!(:medical_bill) { FactoryBot.create(:medical_bill, cost: 111111, user: user) }

  context 'ログインしている場合' do
    before do
      login(user)
    end

    it '医療費を登録できること' do
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
      expect(response).to redirect_to(medical_bills_path)
    end

    it '医療費を編集できること' do
      expect {
        patch medical_bill_path(medical_bill), params: {
          medical_bill: {
            cost: '123456'
          }
        }
      }.to change { medical_bill.reload.cost }.from(111111).to(123456)
      expect(response).to redirect_to(medical_bills_path)
    end

    it '医療費を削除できること' do
      expect {
        delete medical_bill_path(medical_bill)
      }.to change(MedicalBill, :count).by(-1)
      expect(response).to redirect_to(medical_bills_path)
    end
  end

  context 'ログインしていない場合' do
    it do
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
      }.not_to change { MedicalBill.count }
      expect(response).to redirect_to(login_path)
    end
  end
end
