class User < ApplicationRecord
  has_secure_password
  has_many :medical_bills
  has_many :family_members

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
end
