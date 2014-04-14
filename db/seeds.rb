# Database initial data

ModelDiscovery::Engine.load_seed

Faalis::Workflows::Discovery.build_table_list

Faalis::Group.create({:name => 'Admin'})

Faalis::User.create({:email => 'admin@example.com',
                     :group_id => 1,
                     :password => '123123123',
                     :password_confirmation => '123123123'})


Faalis::Group.create({:name => 'Guest', :id => 2})


Faalis::User.create({:email => 'user@example.com',
            :group_id => 2,
            :password => '123123123',
            :password_confirmation => '123123123'})
