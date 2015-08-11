class AddPermissionsGroupsTable < ActiveRecord::Migration
  def change
    create_table :faalis_groups_permissions do |t|
      t.belongs_to :permission
      t.belongs_to :group
    end
  end
end
