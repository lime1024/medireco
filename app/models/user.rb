class User < ApplicationRecord
  has_secure_password
  has_many :medical_bills
end
