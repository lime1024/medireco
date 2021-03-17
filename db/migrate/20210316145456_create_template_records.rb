class CreateTemplateRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :template_records do |t|
      t.integer :cost
      t.references :classification, null: false, foreign_key: true, index: false
      t.references :family_member, null: false, foreign_key: true, index: false
      t.references :payee, null: false, foreign_key: true, index: false
      t.references :user, null: false, foreign_key: true, index: false
      t.references :template, null: false, foreign_key: true, index: false

      t.timestamps
    end
  end
end
