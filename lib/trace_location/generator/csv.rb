# frozen_string_literal: true

require 'csv'

module TraceLocation
  module Generator
    class Csv < Base # :nodoc:
      ATTRIBUTES = %w[id event path lineno caller_path caller_lineno method_str hierarchy].freeze

      def initialize(events, return_value, options)
        super
        @dest_dir = options.fetch(:dest_dir) { ::TraceLocation.config.dest_dir }
        @file_path = File.join(@dest_dir, "trace_location-#{Time.now.strftime('%Y%m%d%H%m%s')}.csv")
      end

      def generate
        setup_dir
        create_file
        $stdout.puts "Created at #{file_path}"
      end

      private

      attr_reader :events, :return_value, :dest_dir, :file_path

      def setup_dir
        FileUtils.mkdir_p(dest_dir)
      end

      def create_file
        CSV.open(file_path, 'wb+') do |csv|
          csv << ATTRIBUTES

          events.each do |event|
            csv << ATTRIBUTES.map { |attr| event.public_send(attr) }
          end
        end
      end
    end
  end
end
