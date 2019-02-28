class AddUserIdToPayees < ActiveRecord::Migration[5.2]
  def up
    add_reference :payees, :user, null: false, index: true
  end

  def down
    remove_reference :payees, :user, index: true
  end
end
