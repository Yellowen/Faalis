# Read about factories at https://github.com/thoughtbot/factory_girl

def group(role)
  # get existing group or create new one
  Faalis::Group.where(role: role).first || Fabricate("#{role}_group")
end

Fabricator :guest_group, class_name: 'Faalis::Group' do
  name 'Guest'
  role 'guest'
end

Fabricator :admin_group, class_name: 'Faalis::Group' do
  name 'Admin'
  role 'admin'
end

Fabricator :manager_group, class_name: 'Faalis::Group' do
  name 'Manager'
  role 'manager'

  permissions do
    [:index, :show, :update, :create, :destroy].map do |x|
      define_permission(x, :group)
    end
  end
end
