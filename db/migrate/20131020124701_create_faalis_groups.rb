class CreateFaalisGroups < ActiveRecord::Migration
  def change
    args = {}
    args[:id] = :uuid if Faalis::Engine.use_uuid

    create_table :faalis_groups, **args do |t|
      t.string :name
      t.string :role

      t.timestamps
    end

    add_index :faalis_groups, :role, unique: true
  end
end
