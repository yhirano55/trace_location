require 'optparse'

module TraceLocation
  class CLI
    attr_reader :argv

    def initialize(argv)
      @argv = argv
    end

    def run
      opt = OptionParser.new
      opt.on('-f FORMAT', '--format=FORMAT', 'Report format (default: :md)', &:to_sym)
      opt.on('-m REGEXP', '--match=REGEXP') { |str| Regexp.new(str) }
      opt.on('-i REGEXP', '--ignore=REGEXP') { |str| Regexp.new(str) }
      opt.on('-d DIR', '--dest-dir=DIR')
      opt.on('-e code')

      params = {}
      opt.order!(argv, into: params)
      params.transform_keys! { |k| k.to_s.gsub('-', '_').to_sym }

      if code = params.delete(:e)
        exec_code code, params
      else
        file = argv.shift
        unless file
          puts opt.help
          exit 1
        end

        exec_command file, params
      end
    end

    private

    def exec_command(cmd, params)
      path =
        if File.exist?(cmd)
          cmd
        else
          `which #{cmd}`.chomp
        end

      $PROGRAM_NAME = cmd

      TraceLocation.trace(params) do
        load path
      end
    end

    def exec_code(code, params)
      TraceLocation.trace(params) do
        eval code
      end
    end
  end
end
