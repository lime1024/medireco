class MedicalBill < ApplicationRecord
  def self.search(search)
    if search
      MedicalBill.where("day BETWEEN ? AND ?", "#{search}-01-01", "#{search}-03-31")
    else
      MedicalBill.all
    end
  end
  
  validates :day, presence: true
  validates :name, presence: true
  validates :payee, presence: true
  validates :classification, presence: true
  validates :cost, presence: true
end
