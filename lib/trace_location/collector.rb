# frozen_string_literal: true

module TraceLocation
  module Collector # :nodoc:
    require_relative 'event'
    Result = Struct.new(:events, :return_value)

    def self.collect(&block)
      events = []
      hierarchy = 0
      tracer = TracePoint.new(:call, :return) do |trace_point|
        case trace_point.event
        when :call
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
          hierarchy -= 1

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
