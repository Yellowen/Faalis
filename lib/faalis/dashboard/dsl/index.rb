require_dependency 'faalis/dashboard/dsl/base'

module Faalis::Dashboard::DSL
  class Index < Base

    alias_method :table_fields, :attributes
  end
end
