# frozen_string_literal: true

module TraceLocation
  class Railtie < ::Rails::Railtie # :nodoc:
    config.before_initialize do
      ::TraceLocation.configure do |config|
        config.dest_dir = Rails.root.join('log')
      end
    end
  end
end
