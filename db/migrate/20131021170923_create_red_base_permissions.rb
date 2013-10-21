class CreateRedBasePermissions < ActiveRecord::Migration
  def change
    create_table :red_base_permissions do |t|
      t.string :model
      t.string :permission_type

      t.timestamps
    end
  end
end
