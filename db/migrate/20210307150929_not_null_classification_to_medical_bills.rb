class NotNullClassificationToMedicalBills < ActiveRecord::Migration[6.0]
  def up
    change_column_null :medical_bills, :classification, true
  end

  def down
    change_column_null :medical_bills, :classification, false
  end
end
