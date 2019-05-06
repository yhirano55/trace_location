# frozen_string_literal: true

require 'fileutils'

module TraceLocation
  module Generator
    class Log < Base # :nodoc:
      EVENTS = { call: 'C', return: 'R' }.freeze
      INDENT_SPACES = 2
      INDENT_STRING = ' '

      def initialize(events, return_value, options)
        @events = events
        @return_value = return_value
        @gems_dir = ::TraceLocation.config.gems_dir
        @dest_dir = options.fetch(:dest_dir) { ::TraceLocation.config.dest_dir }
        @current = Time.now
        @filename = "trace_location-#{@current.strftime('%Y%m%d%H%m%s')}.log"
        @file_path = File.join(@dest_dir, @filename)
      end

      def generate
        setup_dir
        create_file
        $stdout.puts "Created at #{file_path}"
      end

      private

      attr_reader :events, :return_value, :gems_dir, :dest_dir, :current, :filename, :file_path

      def setup_dir
        FileUtils.mkdir_p(dest_dir)
      end

      def create_file
        File.open(file_path, 'w+') do |io|
          io.puts "Logged by TraceLocation gem at #{current}"
          io.puts 'https://github.com/yhirano55/trace_location'
          io.puts
          io.puts '[Tracing events] C: Call, R: Return'
          io.puts
          io.puts format_events(events).join("\n")
          io.puts
          io.puts "Result: #{return_value}"
        end
      end

      def format_events(events)
        events.select(&:valid?).map do |e|
          indent = indent(e.hierarchy)
          event = EVENTS[e.event]
          path = e.path.to_s.gsub(/#{gems_dir}/, '')

          %(#{indent}#{event} #{path}:#{e.lineno} [#{e.method_str}])
        end
      end

      def indent(hierarchy)
        INDENT_STRING * (hierarchy * INDENT_SPACES)
      end
    end
  end
end
