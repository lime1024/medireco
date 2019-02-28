class RemovePayeeFromMedicalBills < ActiveRecord::Migration[5.2]
  def change
    remove_column :medical_bills, :payee, :string
  end
end
