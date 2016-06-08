class AddPermissionsGroupsTable < ActiveRecord::Migration
  def change
    args = {}
    args[:id] = :uuid if Faalis::Engine.use_uuid

    create_table :faalis_groups_permissions, **args do |t|
      if Faalis::Engine.use_uuid
        t.uuid :permission_id
        t.uuid :group_id
      else
        t.belongs_to :permission
        t.belongs_to :group
      end
    end
  end
end
