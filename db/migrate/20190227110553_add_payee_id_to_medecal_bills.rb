class AddPayeeIdToMedecalBills < ActiveRecord::Migration[5.2]
  def up
    add_reference :medical_bills, :payee, null: false
  end

  def down
    remove_reference :medical_bills, :payee
  end
end
