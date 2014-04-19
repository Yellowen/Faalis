namespace :faalis do
  namespace :sync do

    desc "Sync up workflows"
    task :workflows => :environment do
      Faalis::Workflow.destroy_all
      Faalis::Workflows::Discovery.build_table_list
    end
  end
end
