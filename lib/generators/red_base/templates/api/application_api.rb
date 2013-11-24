module API
  class ApplicationAPI < RedBase::API::Base

    setup_api


    mount RedBase::API::Root

    # Mount your Api modules here

  end
end
