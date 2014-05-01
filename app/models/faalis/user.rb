# -----------------------------------------------------------------------------
#    Faalis - Basic website skel engine
#    Copyright (C) 2012-2013 Yellowen
#
#    This program is free software; you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation; either version 2 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License along
#    with this program; if not, write to the Free Software Foundation, Inc.,
#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
# -----------------------------------------------------------------------------

module Faalis
  class User < ActiveRecord::Base
    #acts as messageable for mailboxer
    acts_as_messageable

    validates :password, presence: true, length: {minimum: 5, maximum: 120}, on: :create
    validates :password, length: {minimum: 5, maximum: 120}, on: :update, allow_blank: true
    validates :email, presence: true, length: {minimum: 6}
    #validates :password,presence: true, length: { in: 6..20 }
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
                        :validatable,
                        :omniauthable]

    if Rails.env.production?
      @@devise_options << :confirmable
    end

    if Devise.omniauth_configs.any?
      @@devise_options << :omniauthable
      @@devise_options << {:omniauth_providers => Devise.omniauth_configs.keys}
    end

    belongs_to :group

    devise *@@devise_options

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

    def password_required?
      # TODO: nil? is not suitable for here we should use empty? or blink?
      if Devise.omniauth_configs.any?
        return (provider.nil? || password.nil?) && super
      else
         password.nil? && super
      end
    end

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
