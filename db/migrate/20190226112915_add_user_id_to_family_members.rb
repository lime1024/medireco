class AddUserIdToFamilyMembers < ActiveRecord::Migration[5.2]
  def up
    add_reference :family_members, :user, null: false, index: true
  end

  def down
    remove_reference :family_members, :user, index: true
  end
end
