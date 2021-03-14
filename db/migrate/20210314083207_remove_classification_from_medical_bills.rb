class RemoveClassificationFromMedicalBills < ActiveRecord::Migration[6.0]
  def up
    remove_column :medical_bills, :classification, :string
    change_column_null :medical_bills, :classification_id, false
  end

  def down
    add_column :medical_bills, :classification, :string
    change_column_null :medical_bills, :classification_id, true
  end
end
