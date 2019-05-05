# frozen_string_literal: true

module TraceLocation
  module Report # :nodoc:
    require_relative 'generator'

    class InvalidFormatError < ArgumentError; end

    GENERATORS = {
      log: ::TraceLocation::Generator::Log
    }.freeze

    def self.build(events, return_value, options)
      resolve_generator(options[:format]).new(events, return_value, options)
    end

    def self.resolve_generator(format)
      format ||= TraceLocation.config.default_format
      GENERATORS.fetch(format) { raise InvalidFormatError }
    end
  end
end
