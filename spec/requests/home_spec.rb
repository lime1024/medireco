require 'rails_helper'

RSpec.describe 'Home', type: :request do
  let(:user) { FactoryBot.create(:user) }

  context 'ログインしている場合' do
    before do
      login(user)
    end

    it 'root にアクセスすると medical_bills にリダイレクトされること' do
      get root_path
      expect(response).to redirect_to(medical_bills_path)
    end
  end

  context 'ログインしていない場合' do
    it 'root にアクセスすると medical_bills にリダイレクトされないこと' do
      get root_path
      expect(response).to have_http_status(200)
    end
  end
end
