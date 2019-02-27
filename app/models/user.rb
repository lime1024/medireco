class User < ApplicationRecord
  has_secure_password
  has_many :medical_bills, dependent: :destroy
  has_many :family_members, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
end
