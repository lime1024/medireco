class User < ApplicationRecord
  has_secure_password
  has_many :medical_bills, dependent: :destroy
  has_many :family_members, dependent: :destroy
  has_many :payees, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: {
    with: /[\w\-._]+@[\w\-._]+\.[A-Za-z]/
  }
end
