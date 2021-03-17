class AddClassificationIdToMedicalBills < ActiveRecord::Migration[6.0]
  def change
    add_reference :medical_bills, :classification, foreign_key: true
  end
end
