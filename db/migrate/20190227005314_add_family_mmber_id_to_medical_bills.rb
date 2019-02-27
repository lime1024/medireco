class AddFamilyMmberIdToMedicalBills < ActiveRecord::Migration[5.2]
  def up
    add_reference :medical_bills, :family_member, null: false
  end

  def down
    remove_reference :medical_bills, :family_member
  end
end
