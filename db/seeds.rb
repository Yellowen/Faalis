# Database initial data

ModelDiscovery::Engine.load_seed

#Faalis::Workflows::Discovery.build_table_list

case Faalis::ORM.current
when 'active_record'
  Faalis::Group.create(name: 'Admin')

  Faalis::User.create(email: 'admin@example.com',
                      group_id: 1,
                      password: '123123123',
                      password_confirmation: '123123123')


  Faalis::Group.create(name: 'Guest', id: 2)


  Faalis::User.create(email: 'user@example.com',
                      group_id: 2,
                      password: '123123123',
                      password_confirmation: '123123123')
when 'mongoid'
  admin = Faalis::User.create(email: 'admin@example.com',
                              password: '123123123',
                              password_confirmation: '123123123')

  admin.groups = [Faalis::Group.new(name: 'Admin')]

  guest = Faalis::User.create(email: 'user@example.com',
                              password: '123123123',
                              password_confirmation: '123123123')
  guest.groups = [Faalis::Group.new(name: 'Guest')]
end


Faalis::Discovery::Permissions.create_all_permissions
