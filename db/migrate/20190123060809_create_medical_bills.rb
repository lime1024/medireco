class CreateMedicalBills < ActiveRecord::Migration[5.2]
  def change
    create_table :medical_bills do |t|
      t.date :day
      t.string :name
      t.string :payee
      t.string :classification
      t.integer :cost

      t.timestamps
    end
  end
end
