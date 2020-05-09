module UserSupport
  module Request
    def login(user)
      post login_path, params: {
        session: {
          email: user.email,
          password: user.password
        }
      }
    end
  end

  module System
    def login(user)
      visit login_path
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: user.password
      click_button 'ログイン'
    end
  end
end

RSpec.configure do |c|
  c.include UserSupport::Request, type: :request
  c.include UserSupport::System, type: :system
end
