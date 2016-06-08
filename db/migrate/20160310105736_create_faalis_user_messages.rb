class CreateFaalisUserMessages < ActiveRecord::Migration
  def change
    args = {}
    args[:id] = :uuid if Faalis::Engine.use_uuid

    create_table :faalis_user_messages, **args do |t|
      if Faalis::Engine.use_uuid
        t.uuid :sender_id
        t.uuid :receiver_id
      else
        t.integer :sender_id
        t.integer :receiver_id
      end

      t.boolean :read_only
      t.text :content
      t.text :raw_content

      t.timestamps
    end

    add_index :faalis_user_messages, :sender_id
    add_index :faalis_user_messages, :receiver_id
  end
end
