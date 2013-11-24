class AddPermissionsGroupsTable < ActiveRecord::Migration
  def change
    create_table :red_base_permissions_groups do |t|
      t.belongs_to :red_base_permissions
      t.belongs_to :red_base_groups
    end
  end
end
