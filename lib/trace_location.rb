# frozen_string_literal: true

require_relative 'trace_location/version'
require_relative 'trace_location/config'
require_relative 'trace_location/tracer'

begin
  require 'rails'
  require_relative 'trace_location/railtie'
rescue LoadError
  nil
end

module TraceLocation # :nodoc:
  def self.trace(options = {}, &block)
    Tracer.new(options).call(&block)
  end

  def self.configure
    yield config
  end

  def self.config
    @config ||= Config.new
  end
end
