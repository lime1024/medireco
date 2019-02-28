class FamilyMember < ApplicationRecord
  belongs_to :user
  has_many :medical_bills, dependent: :restrict_with_error

  validates :name, presence: true
end
