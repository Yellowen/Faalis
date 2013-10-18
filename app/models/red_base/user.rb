module RedBase
  class User < ActiveRecord::Base
    # Include default devise modules. Others available are:
    # :token_authenticatable, :confirmable,
    # :lockable, :timeoutable and :omniauthable
    @@devise_options = [:database_authenticatable,
                        :registerable,
                        :recoverable,
                        :rememberable,
                        :trackable,
                        :lockable,
                        :timeoutable,
                        :validatable]

    if Rails.env.production?
      @@devise_options << :confirmable
    end

    if Devise.omniauth_configs.any?
      @@devise_options << :omniauthable
      @@devise_options << {:omniauth_providers => Devise.omniauth_configs.keys}
    end

    devise *@@devise_options

    def self.find_from_oauth(auth, signed_in_resource=nil)
      user = User.where(:provider => auth.provider, :uid => auth.uid).first

      first_name = auth.info.first_name
      last_name = auth.info.last_name

      if first_name.blank?
        # With first_name being blank last_name is probably is blank too
        name = auth.info.name.split(" ")
        first_name = name[0]
        last_name = name[1,] || ""
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
