module Faalis
  module User::AuthDefinitions

    def self.included(base)

      base.class_eval do
        # Include default devise modules. Others available are:
        # :token_authenticatable, :confirmable,
        # :lockable, :timeoutable and :omniauthable
        @@devise_options = Faalis::Engnine.devise_options

        if Devise.omniauth_configs.any?
          @@devise_options << :omniauthable
          @@devise_options << {:omniauth_providers => Devise.omniauth_configs.keys}
        end
      end
      base.extend ClassMethods
    end

    def name
      if first_name or last_name
        "#{first_name} #{last_name}"
      else
        email
      end

    end

    def full_name
      name
    end


    # Confirmation not required when using omniauth
    def confirmation_required?
      super && identities.empty?
    end

    def update_with_password(params, *options)
      if encrypted_password.blank?
        update_attributes(params, *options)
      else
        super
      end
    end

    def password_required?
      # TODO: nil? is not suitable for here we should use empty? or blink?
      if Devise.omniauth_configs.any?
        return (provider.nil? || password.nil?) && super
      else
        password.nil? && super
      end
    end

    module ClassMethods
      def find_from_oauth(auth, signed_in_resource = nil)
        user = User.where(:provider => auth.provider, :uid => auth.uid).first

        first_name = auth.info.first_name
        last_name = auth.info.last_name

        if first_name.blank?
          # With first_name being blank last_name is probably is blank too
          name = auth.info.name.split(' ')
          first_name = name[0]
          last_name = name[1,] || ''
        end
        unless user
          user = User.create(first_name: first_name,
                             last_name: last_name,
                             provider: auth.provider,
                             uid: auth.uid,
                             email: auth.info.email,
                             password: Devise.friendly_token[0,20])
        end
        user
      end

    end

  end
end
