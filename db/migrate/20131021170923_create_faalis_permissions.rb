class CreateFaalisPermissions < ActiveRecord::Migration
  def change
    create_table :faalis_permissions do |t|
      t.string :model
      t.string :permission_type

      t.timestamps
    end

    add_index :faalis_permissions, :model
  end
end
