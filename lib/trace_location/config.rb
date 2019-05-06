# frozen_string_literal: true

module TraceLocation
  class Config # :nodoc:
    attr_accessor :gems_dir, :dest_dir, :default_format

    def initialize
      @gems_dir = File.join(Gem.path[0], 'gems')
      @dest_dir = Dir.pwd
      @default_format = :log
    end
  end
end
