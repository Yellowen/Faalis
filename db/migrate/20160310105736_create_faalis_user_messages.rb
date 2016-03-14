class CreateFaalisUserMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :faalis_user_messages do |t|
      t.integer :sender_id
      t.integer :reciver_id
      t.boolean :read_only
      t.text :content
      t.text :raw_content

      t.timestamps
    end

    add_index :faalis_user_messages, :sender_id
    add_index :faalis_user_messages, :reciver_id
  end
end
