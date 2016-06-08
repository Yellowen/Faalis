class AddUsersGroupsTable < ActiveRecord::Migration
  def change
    create_table :faalis_groups_users do |t|
      if Faalis::Engine.use_uuid
        t.uuid :user_id
        t.uuid :group_id
      else
        t.belongs_to :user
        t.belongs_to :group
      end
    end
  end
end
