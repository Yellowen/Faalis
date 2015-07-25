# Database initial data
ModelDiscovery::Engine.load_seed

#Faalis::Workflows::Discovery.build_table_list
Faalis::Discovery::Permissions.create_all_permissions

case Faalis::ORM.current
when 'active_record'
  admin_group = Faalis::Group.create(name: 'Admin', role: 'admin')
  guest_group = Faalis::Group.create(name: 'Guest', role: 'guest')

  admin_group.permissions = Faalis::Permission.all

  admin = Faalis::User.create(email: 'admin@example.com',
                              password: 'changeme',
                              password_confirmation: '123123123')
  admin.groups << admin_group


  user = Faalis::User.create(email: 'user@example.com',
                             password: '123123123',
                             password_confirmation: '123123123')
  user.groups << guest_group

when 'mongoid'
  admin_group = Faalis::Group.create(name: 'Admin', role: 'admin')
  Faalis::Permission.each do |perm|
    admin_group.permissions << perm
  end
  admin_group.save!

  guest_group = Faalis::Group.create(name: 'Guest', role: 'guest')

  admin = Faalis::User.new(email: 'admin@example.com',
                           password: 'changeme',
                           password_confirmation: '123123123')


  admin.groups << admin_group

  user = Faalis::User.new(email: 'user@example.com',
                          password: '123123123',
                          password_confirmation: '123123123')

  guest_group = Faalis::Group.new(name: 'Guest', role: 'guest')
  user.groups = [guest_group]
end

admin.save
user.save
