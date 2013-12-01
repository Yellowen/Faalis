# Database initial data

RedBase::Group.create({:name => "Admin"})
RedBase::Group.create({:name => "Guest", :id => 2})

RedBase::User.create({
                       :email => "admin@example.com",
                       :group_id => 1,
                       :password => "123123123",
                       :password_confirmation => "123123123"})

RedBase::User.create({:email => "user@example.com",
            :group_id => 999,
            :password => "123123123",
            :password_confirmation => "123123123"})
