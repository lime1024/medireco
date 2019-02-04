class ChangeMedicalBillsNotNull < ActiveRecord::Migration[5.2]
  def change
    change_column_null :medical_bills, :day, false
    change_column_null :medical_bills, :name, false
    change_column_null :medical_bills, :payee, false
    change_column_null :medical_bills, :classification, false
    change_column_null :medical_bills, :cost, false
  end
end
