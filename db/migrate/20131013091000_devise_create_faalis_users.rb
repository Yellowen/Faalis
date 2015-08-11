class DeviseCreateFaalisUsers < ActiveRecord::Migration
  def change
    create_table(:faalis_users) do |t|
      ## Database authenticatable
      t.string :email,              :null => false, :default => ""
      t.string :encrypted_password, :null => false, :default => ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, :default => 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip


      t.string   :first_name
      t.string   :last_name

      if not Devise.omniauth_providers.empty?
        # Service
        t.string   :provider, :default => ""
        t.string   :uid
      end

      if Rails.env.production?
        ## Confirmable
        t.string   :confirmation_token
        t.datetime :confirmed_at
        t.datetime :confirmation_sent_at
        t.string   :unconfirmed_email # Only if using reconfirmable

        # Token authenticatable
        t.string :authentication_token
      end

      ## Lockable
      t.integer  :failed_attempts, :default => 0 # Only if lock strategy is :failed_attempts
      t.string   :unlock_token # Only if unlock strategy is :email or :both
      t.datetime :locked_at



      t.timestamps
    end

    add_index :faalis_users, :email,                unique: true
    add_index :faalis_users, :reset_password_token, unique: true

    if Rails.env.production?
      add_index :faalis_users, :confirmation_token, unique: true
    end
    add_index :faalis_users, :unlock_token,         unique: true
    # add_index :faalis_users, :authentication_token, :unique => true
  end
end
