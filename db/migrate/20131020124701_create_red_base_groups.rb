class CreateRedBaseGroups < ActiveRecord::Migration
  def change
    create_table :red_base_groups do |t|
      t.string :name

      t.timestamps
    end
  end
end
