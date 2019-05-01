# frozen_string_literal: true

module TraceLocation
  class Tracer # :nodoc:
    EVENTS = { call: 'C', return: 'R' }.freeze
    INDENT_SPACES = 2
    INDENT_STRING = ' '

    def initialize(options = {})
      @root_dir = options.fetch(:root_dir) { TraceLocation.config.root_dir }
      @dest_dir = options.fetch(:dest_dir) { TraceLocation.config.dest_dir }
    end

    def call(&block)
      logs = []
      nest = 0
      trace_point = TracePoint.new(:call, :return) do |tp|
        case tp.event
        when :call
          logs << build_log(trace_point: tp, nest: nest, root_dir: root_dir)
          nest += 1
        when :return
          nest = nest.positive? ? nest - 1 : 0
          logs << build_log(trace_point: tp, nest: nest, root_dir: root_dir)
        end
      end

      trace_point.enable
      result = block.call
      trace_point.disable

      current = Time.now
      filename = "trace_location-#{current.strftime('%Y%m%d%H%m%s')}.log"
      file_path = File.join(dest_dir, filename)
      File.open(file_path, 'w+') do |io|
        io.puts "Logged by TraceLocation gem at #{current}"
        io.puts 'https://github.com/yhirano55/trace_location'
        io.puts
        io.puts '[Tracing events] C: Call, R: Return'
        io.puts
        io.puts logs.join("\n")
        io.puts
        io.puts "Result: #{result.inspect}"
      end
      $stdout.puts "Created at #{file_path}"
      true
    rescue StandardError => e
      $stdout.puts "Failure: #{e.message}"
      false
    ensure
      trace_point.disable if trace_point.enabled?
    end

    private

    attr_reader :root_dir, :dest_dir, :block

    def build_log(trace_point:, nest:, root_dir:)
      indent    = indent(nest)
      event     = EVENTS[trace_point.event]
      path      = trace_point.path.to_s.gsub(/#{root_dir}/, '')
      lineno    = trace_point.lineno
      method_id = trace_point.method_id

      %(#{indent}#{event} #{path}:#{lineno}##{method_id})
    end

    def indent(nest)
      INDENT_STRING * (nest * INDENT_SPACES)
    end
  end
end
