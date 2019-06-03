# frozen_string_literal: true

module TraceLocation
  class CLI # :nodoc:
    def self.start(args)
      command = extract_command(args)
      unless command
        print_help
        exit
      end

      TraceLocation.trace(format: :markdown) do
        `#{command}`
      end

      exit
    end

    def self.print_help
      puts 'Usage:'
      puts "  trace_location 'rails g model User name:string'"
    end

    def self.extract_command(args)
      meth = args.first.to_s unless args.empty?
      args.shift if meth && (meth !~ /^\-/)
    end
  end
end
