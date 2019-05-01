# frozen_string_literal: true

module TraceLocation
  class Railtie < ::Rails::Railtie # :nodoc:
    config.after_initialize do
      ::TraceLocation.configure do |config|
        config.root_dir = Rails.root
        config.dest_dir = Rails.root.join('log')
      end
    end
  end
end
