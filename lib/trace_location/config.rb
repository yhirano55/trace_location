# frozen_string_literal: true

module TraceLocation
  class Config # :nodoc:
    attr_accessor :current_dir, :dest_dir, :default_format

    def initialize
      @current_dir = Dir.pwd
      @dest_dir = Dir.pwd
      @default_format = :markdown
    end
  end
end
