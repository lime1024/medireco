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
  validate :can_not_set_future_date

  def can_not_set_future_date
    if !day.nil? && day > Date.today
      errors.add(:day, 'は未来日を入力できません')
    end
  end
end
