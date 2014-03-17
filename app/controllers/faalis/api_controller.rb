# -----------------------------------------------------------------------------
#    Faalis - Basic website skel engine
#    Copyright (C) 2012-2013 Yellowen
#
#    This program is free software; you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation; either version 2 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License along
#    with this program; if not, write to the Free Software Foundation, Inc.,
#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
# -----------------------------------------------------------------------------
require_dependency "faalis/api_controller"


# This class is the base class of all API controllers in any **Faalis**
# host applications. Each host Rails application should have an `APIController`
# which inherit from this class.
class Faalis::APIController < Faalis::ApplicationController

  @@allowed_fields = []

  # Only support `json` format
  respond_to :json

  # Authenticate user before any action take place
  before_filter :authenticate

  # Check for any presence of filtering query, In querystring and load
  # resource using them
  before_filter :load_resource_by_query, :only => [:index]


  protect_from_forgery

  # Set csrf cookie after any action
  after_filter :set_csrf_cookie_for_ng

  # Rescue from any access denied exception raised from cancan and
  # returns a useful error message in json
  rescue_from CanCan::AccessDenied do |exception|

    render :status => 403, :json => {
      :error => _("You don't have access to this page"),
      :orig_msg => exception.message,
      :action => exception.action,
    }
  end

  def set_csrf_cookie_for_ng
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end

  # User authentication for API services take place here. By default
  # **Faalis** uses the authentication method of **Devise** to authenticate
  # access to API service.
  #
  # If you want to change authentication method ? just override this method
  # in you **APIController**
  def authenticate
    authenticate_user!
  end

  # Load resource by using parameters specified in querystring.
  def load_resource_by_query
    # If any query string parameter provided and allow fields specified
    if not request.query_parameters.empty? and not allowed_fields.empty?
      #load_resource

      # Iterate over parameters in query string
      request.query_parameters.each do |key, value|
        # each key can be like filename[__querytype]=value
        # which `querytype` is string that specify the query type scope
        # to use in model. For example these is a query type scope called
        # `gt` which mean the mentioned field should be greater than the
        # value
        field, query_type = key.split("__")

        if allowed_fields.include? field
          # If field name is in the allowed list
          # If no query type specified we will use assignment scope.
          if query_type.nil?
            query_type = "assignment"
          end

          # If model have an scope with the "#{query_type}_query" name.
          # Otherwise skip
          if model_class.respond_to? "#{query_type}_query"

            # If resource already loaded. If there was a instnace variable
            # with the plural name of the resource exists then resource
            # already loaded and we should chain new conditions
            if instance_variable_defined? "@#{controller_name}"
              instance_variable_get("@#{controller_name}").send("#{query_type}_query".to_sym, field, value)
            else
              # Resource did not loaded we make first query
              # (without touching database) and set the corresponding
              # instance variables
              relation_object = model_class.send("#{query_type}_query".to_sym, field, value)
              instance_variable_set("@#{controller_name}", relation_object)
            end

          else
            logger.info "There is no `#{query_type}_query` in `#{model_class.to_s}` model."
          end
        else
          logger.warn "`#{field}` in not in allowed list for `#{self.class.to_s}`."
        end

      end
    end
  end

  # An array of allowed fields for query loading
  def allowed_fields
    @@allowed_fields
  end

  # Using this query you can activate the query loading system
  # and specify fields which you want to use in query loading
  def self.allow_query_on(*args)
    @@allowed_fields = args.to_a.collect { |x| x.to_s }
  end


  protected

  # Model class related to this controller.
  def model_class
    controller_name.singularize.classify.constantize
  end

  def verified_request?
    super || form_authenticity_token == request.headers['X-XSRF-TOKEN']
  end

end
