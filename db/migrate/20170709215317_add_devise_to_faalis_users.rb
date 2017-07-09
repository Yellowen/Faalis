class AddDeviseToFaalisUsers < ActiveRecord::Migration[5.1]
  def self.up
    args = {}
    args[:id] = :uuid if Faalis::Engine.use_uuid

    create_table :faalis_users do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""
      t.string :first_name, null: false, default: ""
      t.string :last_name,  null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      if not Rails.env.development? and not Rails.env.test?
        ## Confirmable
        t.string   :confirmation_token
        t.datetime :confirmed_at
        t.datetime :confirmation_sent_at
        t.string   :unconfirmed_email # Only if using reconfirmable

        # Token authenticatable
        t.string :authentication_token
      end

      ## Lockable
      # Only if lock strategy is :failed_attempts
      t.integer  :failed_attempts, default: 0, null: false
      # Only if unlock strategy is :email or :both
      t.string   :unlock_token
      t.datetime :locked_at

      if not Devise.omniauth_providers.empty?
        # Service
        t.string   :provider, :default => ""
        t.string   :uid
      end
    end

    add_index :faalis_users, :email,                unique: true
    add_index :faalis_users, :reset_password_token, unique: true

    if not Rails.env.development? and not Rails.env.test?
      add_index :faalis_users, :confirmation_token,   unique: tru
    end

    add_index :faalis_users, :unlock_token,         unique: true
  end

  def self.down
    # By default, we don't want to make any assumption about how to roll back a migration when your
    # model already existed. Please edit below which fields you would like to remove in this migration.
    raise ActiveRecord::IrreversibleMigration
  end
end
