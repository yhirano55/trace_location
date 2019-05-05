# frozen_string_literal: true

module TraceLocation
  class Config # :nodoc:
    attr_accessor :root_dir, :dest_dir, :default_format

    def initialize
      @root_dir = Dir.pwd
      @dest_dir = Dir.pwd
      @default_format = :log
    end
  end
end
