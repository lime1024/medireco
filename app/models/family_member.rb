class FamilyMember < ApplicationRecord
  belongs_to :user
  has_many :medical_bill

  validates :name, presence: true
end
