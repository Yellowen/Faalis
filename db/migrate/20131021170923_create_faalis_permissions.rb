class CreateFaalisPermissions < ActiveRecord::Migration
  def change
    args = {}
    args[:id] = :uuid if Faalis::Engine.use_uuid

    create_table :faalis_permissions, **args do |t|
      t.string :model
      t.string :permission_type

      t.timestamps
    end

    add_index :faalis_permissions, :model
  end
end
