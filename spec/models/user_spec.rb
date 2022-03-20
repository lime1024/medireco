require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'email_validates' do
    context 'email がフォーマット通りではない場合' do
      it '登録できないこと' do
        user = described_class.new(name: 'はまち', email: 'aaaaaaaaaaaaa', password: 'password')
        expect(user).to_not be_valid
      end
    end
  end
end
