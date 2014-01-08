# Database initial data

Faalis::Group.create({:name => "Admin"})
Faalis::Group.create({:name => "Guest", :id => 2})

Faalis::User.create({
                       :email => "admin@example.com",
                       :group_id => 1,
                       :password => "123123123",
                       :password_confirmation => "123123123"})

Faalis::User.create({:email => "user@example.com",
            :group_id => 999,
            :password => "123123123",
            :password_confirmation => "123123123"})
