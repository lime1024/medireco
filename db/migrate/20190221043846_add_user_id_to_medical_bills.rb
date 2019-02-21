class AddUserIdToMedicalBills < ActiveRecord::Migration[5.2]
  def up
    execute 'DELETE FROM medical_bills;'
    add_reference :medical_bills, :user, null: false, index: true
  end

  def down
    remove_reference :medical_bills, :user, index: true
  end
end
