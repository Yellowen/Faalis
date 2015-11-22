class AddUniquenessIndexToUsersGroups < ActiveRecord::Migration
  def up
    add_index(:faalis_groups_users, [ :user_id, :group_id ],
              unique: true, name: 'by_user_and_group')
  end

  def down
    remove_index(:faalis_groups_users,
                 name: 'by_user_and_group')
  end
end
