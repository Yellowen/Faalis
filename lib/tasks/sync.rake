namespace :faalis do
  namespace :sync do

    desc 'Create missing permissions'
    task :permissions => :environment do
      Faalis::Discovery::Permissions.create_all_permissions
    end
  end
end
