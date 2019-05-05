# frozen_string_literal: true

require_relative 'trace_location/collector'
require_relative 'trace_location/config'
require_relative 'trace_location/report'
require_relative 'trace_location/version'

begin
  require 'rails'
  require_relative 'trace_location/railtie'
rescue LoadError
  nil
end

module TraceLocation # :nodoc:
  def self.trace(options = {}, &block)
    result = Collector.collect(&block)
    Report.build(result.events, result.return_value, options).generate
    true
  rescue StandardError => e
    $stdout.puts "Failure: #{e.message}"
    false
  end

  def self.configure
    yield config
  end

  def self.config
    @config ||= Config.new
  end
end
