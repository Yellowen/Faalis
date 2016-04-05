# Read about factories at https://github.com/thoughtbot/factory_girl

def define_permission(action, model)
  perm = Faalis::Permission.find_by(permission_type: action,
                                    model: "Faalis::#{model.to_s.titleize}")
  perm || Fabricate("#{action}_#{model}")
end

[:index, :show, :update, :create, :destroy].each do |action|
  Fabricator "#{action}_group".to_sym, class_name: 'Faalis::Permission' do
    model 'Faalis::Group'
    permission_type action
  end
end
