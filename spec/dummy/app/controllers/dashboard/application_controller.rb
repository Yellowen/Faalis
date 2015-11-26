class Dashboard::ApplicationController < Faalis::Dashboard::ApplicationController

  def setup_sidebar
    @sidebar = sidebar(t('faalis.engine_name')) do |s|
      s.faalis_entries

      # Put your sidebar entries in here like this:
      #
      # s.menu(title, icon: 'fa fa-book') do
      #   s.item(title,
      #          url: main_app.dashboard_books_path,
      #          model: 'Book')
      # end
      #
      # For more information take a look at `sidebar` section of Faalis guides.
    end
  end
end
