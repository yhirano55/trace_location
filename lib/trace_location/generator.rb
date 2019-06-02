# frozen_string_literal: true

module TraceLocation
  module Generator # :nodoc:
    require_relative 'generator/base'
    require_relative 'generator/csv'
    require_relative 'generator/log'
    require_relative 'generator/markdown'
  end
end
