class MedicalBill < ApplicationRecord
  belongs_to :user
  belongs_to :family_member
  belongs_to :payee
  belongs_to :classification

  validates :day, presence: true
  validates :cost, presence: true, numericality: { greater_than: 0 }
  validate :can_not_set_future_date

  scope :search, -> (search) { where("day BETWEEN ? AND ?", "#{search}-01-01", "#{search}-12-31") }
  scope :this_year, -> {
    today_year = Date.today.year
    where("day BETWEEN ? AND ?", "#{today_year}-01-01", "#{today_year}-12-31")
  }

  class << self
    def select_year
      pluck(:day).map(&:year).uniq
    end

    def summarized_output
      joins(:family_member, :payee, :classification).group("family_members.name", "payees.name", "classifications.name").sum(:cost)
    end

    def this_year_total_cost
      this_year.sum(:cost)
    end
  end

  def can_not_set_future_date
    if !day.nil? && day > Date.today
      errors.add(:day, 'は未来日を入力できません')
    end
  end
end
