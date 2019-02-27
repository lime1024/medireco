class Payee < ApplicationRecord
  has_many :medical_bill
  
  validates :name, presence: true
end
