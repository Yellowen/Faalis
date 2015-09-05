module Faalis::Dashboard
  class FormFieldsProperties

    def initializer
      @fields = {}
    end

    def fields=(all_fields)
      fields.each do |name, field|
        unless all_fields.include? name.to_s
          raise ArgumentError, "'#{name}' is not a valid field"
        end
      end

      all_fields.each do |name, field|
        unless fields.include?(name.to_sym)

          Rails.logger.debug("FIELD NAME: #{name}")
          Rails.logger.debug("FIELD TYPE: #{field.type}")

          if self.respond_to?("setup_#{field.type}".to_sym, true)
            puts "sdasda" * 100
            send("setup_#{field.type}", name)
          end
        end
      end
    end

    def fields
      @fields || {}
    end

    def []=(name, detail)
      @fields ||= {}
      @fields[name.to_sym] = detail
    end

    def [](index)
      unless @fields.nil?
        return @fields[index] || {}
      end
      {}
    end

    def method_missing(m, *args, &block)
      @fields ||= {}
      if self.respond_to? m
        return self.send(m, *args, &block)
      else
        # FIXME: This probably is a bad idea. We should get the whole
        # args
        @fields[m] = args[0]
      end
    end

    def to_hash
      fields
    end


  end
end
