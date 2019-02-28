class Payee < ApplicationRecord
  belongs_to :user
  has_many :medical_bills
  
  validates :name, presence: true
end
