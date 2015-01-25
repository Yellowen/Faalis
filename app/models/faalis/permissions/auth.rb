class Faalis::Permissions::Auth
  # Make this model authorizable
  include Faalis::Concerns::Authorizable

  def self.humanize_class_name
    'Auth Module'
  end
end
