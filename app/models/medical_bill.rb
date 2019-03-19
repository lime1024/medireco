class MedicalBill < ApplicationRecord
  belongs_to :user
  belongs_to :family_member
  belongs_to :payee
  
  def self.search(search)
    if search
      MedicalBill.where("day BETWEEN ? AND ?", "#{search}-01-01", "#{search}-12-31")
    else
      MedicalBill.all
    end
  end

  def self.select_year
    years = MedicalBill.pluck(:day).map do |date|
      date.year
    end
    years.uniq
  end

  def self.summarized_output
    MedicalBill.joins(:family_member, :payee).group("family_members.name", "payees.name", :classification).sum(:cost)
  end

  def self.this_year_total_cost
    today_year = Date.today.year
    this_year = MedicalBill.where("day BETWEEN ? AND ?", "#{today_year}-01-01", "#{today_year}-12-31")
    this_year_total_cost = this_year.sum(:cost)
  end

  validates :day, presence: true
  validates :classification, presence: true
  validates :cost, presence: true
  validate :can_not_set_future_date
  validate :can_not_set_below_zero_yen

  def can_not_set_future_date
    if !day.nil? && day > Date.today
      errors.add(:day, 'は未来日を入力できません')
    end
  end

  def can_not_set_below_zero_yen
    if !cost.nil? && 0 >= cost
      errors.add(:cost, 'は 0 円以下を入力できません')
    end  
  end
end
