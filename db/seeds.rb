# Database initial data

ModelDiscovery::Engine.load_seed

#Faalis::Workflows::Discovery.build_table_list
Faalis::Discovery::Permissions.create_all_permissions

case Faalis::ORM.current
when 'active_record'
  admin_group = Faalis::Group.create(name: 'Admin')

  admin_group.permissions = Faalis::Permission.all

  admin = Faalis::User.create(email: 'admin@example.com',
                              password: '123123123',
                              password_confirmation: '123123123')
  admin.groups << admin_group

  guest_group = Faalis::Group.create(name: 'Guest', id: 2)


  user = Faalis::User.create(email: 'user@example.com',
                             password: '123123123',
                             password_confirmation: '123123123')
  user.groups << guest_group

when 'mongoid'
  admin = Faalis::User.create(email: 'admin@example.com',
                              password: '123123123',
                              password_confirmation: '123123123')

  admin_group = Faalis::Group.create(name: 'Admin')

  Faalis::Permission.each do |perm|
    admin_group.permissions << perm
  end
  admin_group.save!

  admin.groups << admin_group

  user = Faalis::User.create(email: 'user@example.com',
                              password: '123123123',
                              password_confirmation: '123123123')
  guest_group = Faalis::Group.new(name: 'Guest')
  user.groups = [guest_group]
end

admin.save
user.save
