# frozen_string_literal: true

module TraceLocation
  module Generator
    class Base # :nodoc:
      def initialize(events, return_value, options)
        @events       = events
        @return_value = return_value
        @options      = options
      end

      def generate
        raise NotImplementedError
      end
    end
  end
end
