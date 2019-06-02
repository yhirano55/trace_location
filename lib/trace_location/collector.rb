# frozen_string_literal: true

module TraceLocation
  module Collector # :nodoc:
    require_relative 'event'
    Result = Struct.new(:events, :return_value)

    def self.collect(pattern, &block)
      events = []
      hierarchy = 0
      cache = {}

      tracer = TracePoint.new(:call, :return) do |trace_point|
        next if pattern && !trace_point.path.to_s.match?(/#{pattern}/)

        case trace_point.event
        when :call
          cache[trace_point.binding.source_location.join(':')] = hierarchy

          events << Event.new(
            event: trace_point.event,
            path: trace_point.path,
            lineno: trace_point.lineno,
            method_id: trace_point.method_id,
            defined_class: trace_point.defined_class,
            hierarchy: hierarchy
          )

          hierarchy += 1
        when :return
          hierarchy = cache[trace_point.binding.source_location.join(':')] || hierarchy - 1

          events << Event.new(
            event: trace_point.event,
            path: trace_point.path,
            lineno: trace_point.lineno,
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
