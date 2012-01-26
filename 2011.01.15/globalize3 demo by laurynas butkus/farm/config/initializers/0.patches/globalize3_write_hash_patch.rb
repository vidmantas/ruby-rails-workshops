module Globalize
  module ActiveRecord
    class Adapter

      def write_with_hash(locale, name, value)
        if value.is_a?(Hash)
          value.each do |locale, value|
            self.write_without_hash(locale, name, value)
          end
        else
          self.write_without_hash(locale, name, value)
        end
      end

      alias_method_chain :write, :hash

    end
  end
end
