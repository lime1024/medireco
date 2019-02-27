class RemoveNameFromMedicalBills < ActiveRecord::Migration[5.2]
  def up
    remove_column :medical_bills, :name, :string
  end

  def down
    add_column :medical_bills, :name, :string
  end
end
