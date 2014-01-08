class CreateFaalisGroups < ActiveRecord::Migration
  def change
    create_table :faalis_groups do |t|
      t.string :name

      t.timestamps
    end
  end
end
