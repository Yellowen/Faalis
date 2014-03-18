module Faalis
  module Concerns
    # This **concern** provide the default query loading scope for model.
    # Using this, you can make queries like key=value in http request
    # and  Model.assignment(key: value) on you model.
    module Assignment

      def self.included(base)
        base.scope :assignment_query, -> (field, value) do
          base.where(field => value)
       end
      end

    end
  end
end
