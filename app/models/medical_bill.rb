class MedicalBill < ApplicationRecord
  def self.search(search)
    if search
      MedicalBill.where("day BETWEEN ? AND ?", "#{search}-01-01", "#{search}-03-31")
    else
      MedicalBill.all
    end
  end
end
