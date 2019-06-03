# frozen_string_literal: true

require 'binding_of_caller'

module TraceLocation
  module Collector # :nodoc:
    require_relative 'event'
    Result = Struct.new(:events, :return_value)

    def self.collect(pattern, &block)
      events = []
      hierarchy = 0
      id = 0
      cache = {}

      tracer = TracePoint.new(:call, :return) do |trace_point|
        next if pattern && !trace_point.path.to_s.match?(/#{pattern}/)

        id += 1
        location_cache_key = trace_point.binding.source_location.join(':')
        caller_path, caller_lineno = trace_point.binding.of_caller(2).source_location

        case trace_point.event
        when :call
          cache[location_cache_key] = hierarchy

          events << Event.new(
            id: id,
            event: trace_point.event,
            path: trace_point.path,
            lineno: trace_point.lineno,
            caller_path: caller_path,
            caller_lineno: caller_lineno,
            method_id: trace_point.method_id,
            defined_class: trace_point.defined_class,
            hierarchy: hierarchy
          )

          hierarchy += 1
        when :return
          hierarchy = cache[location_cache_key] || hierarchy - 1

          events << Event.new(
            id: id,
            event: trace_point.event,
            path: trace_point.path,
            lineno: trace_point.lineno,
            caller_path: caller_path,
            caller_lineno: caller_lineno,
            method_id: trace_point.method_id,
            defined_class: trace_point.defined_class,
            hierarchy: hierarchy
          )
        end
      end
      return_value = tracer.enable { block.call }
      Result.new(events, return_value)
    end
  end
end
