# frozen_string_literal: true

require 'method_source'

module TraceLocation
  module Collector # :nodoc:
    require_relative 'event'
    Result = Struct.new(:events, :return_value)

    class << self
      def collect(match:, ignore:, methods:, &block)
        methods = Array(methods) if methods
        events = []
        hierarchy = 0
        id = 0
        cache = {}
        method_source_cache = {}

        tracer = TracePoint.new(:call, :return) do |trace_point|
          next if match && !trace_point.path.to_s.match?(/#{Array(match).join('|')}/)
          next if ignore && trace_point.path.to_s.match?(/#{Array(ignore).join('|')}/)
          next if methods && !methods.include?(trace_point.method_id)

          id += 1
          caller_loc = caller_locations(2, 1)[0]
          caller_path = caller_loc.absolute_path
          caller_lineno = caller_loc.lineno
          location_cache_key = "#{caller_path}:#{caller_lineno}"

          mes = extract_method_from(trace_point)
          next if mes.source_location[0].match?(/\A(?:<internal:.+>|\(eval\))\z/)

          method_source =
            if method_source_cache.key?(mes)
              method_source_cache[mes]
            else
              method_source_cache[mes] =
                begin
                  remove_indent(mes.source)
                rescue MethodSource::SourceNotFoundError
                end
            end

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
              owner: mes.owner,
              name: mes.name,
              source: method_source,
              hierarchy: hierarchy,
              is_module: trace_point.self.is_a?(Module)
            )

            hierarchy += 1
          when :return
            hierarchy = cache[location_cache_key] || hierarchy

            events << Event.new(
              id: id,
              event: trace_point.event,
              path: trace_point.path,
              lineno: trace_point.lineno,
              caller_path: caller_path,
              caller_lineno: caller_lineno,
              owner: mes.owner,
              name: mes.name,
              source: method_source,
              hierarchy: hierarchy,
              is_module: trace_point.self.is_a?(Module)
            )
          end
        end
        return_value = tracer.enable { block.call }
        Result.new(events, return_value)
      end

      private

      def extract_method_from(trace_point)
        if trace_point.self.is_a?(Module)
          ::Module.instance_method(:method)
                  .bind(trace_point.self)
                  .call(trace_point.method_id)
        else
          ::Kernel.instance_method(:method)
                  .bind(trace_point.self)
                  .call(trace_point.method_id)
        end
      end

      def remove_indent(source)
        indent = source[/\A(\s*)/, 1]
        source.gsub(/^#{indent}/, '')
      end
    end
  end
end
