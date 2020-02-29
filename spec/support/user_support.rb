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
end

RSpec.configure do |c|
  c.include UserSupport::Request, type: :request
end
