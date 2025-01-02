# frozen_string_literal: true

require_relative 'trace_location/collector'
require_relative 'trace_location/config'
require_relative 'trace_location/report'
require_relative 'trace_location/version'

module TraceLocation # :nodoc:
  def self.trace(options = {}, &block)
    match = options.delete(:match)
    ignore = options.delete(:ignore)
    methods = options.delete(:methods)

    result = Collector.collect(match: match, ignore: ignore, methods: methods, &block)
    Report.build(result.events, result.return_value, options).generate
    true
  rescue StandardError => e
    $stderr.puts 'Failure: TraceLocation got an unexpected error.'
    $stderr.puts e.full_message
    false
  end

  def self.configure
    yield config
  end

  def self.config
    @config ||= Config.new
  end
end

begin
  require 'rails'
  require_relative 'trace_location/railtie'
rescue LoadError
  nil
end
