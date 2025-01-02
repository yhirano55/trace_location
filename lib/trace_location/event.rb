# frozen_string_literal: true

module TraceLocation
  class Event # :nodoc:
    CLASS_FORMAT = /\A#<(?:Class|refinement):([A-Za-z0-9:]+).*>\z/
    attr_reader :id, :event, :path, :lineno, :caller_path, :caller_lineno, :owner, :name, :source, :hierarchy,
                :is_module

    def initialize(id:, event:, path:, lineno:, caller_path:, caller_lineno:, owner:, name:, source:, hierarchy:,
                   is_module:)
      @id = id
      @event = event
      @path = path
      @lineno = lineno
      @caller_path = caller_path
      @caller_lineno = caller_lineno
      @owner = owner
      @name = name
      @source = source
      @hierarchy = hierarchy.to_i
      @is_module = is_module
    end

    def valid?
      hierarchy >= 0
    end

    def invalid?
      !valid?
    end

    def call?
      event == :call
    end

    def return?
      event == :return
    end

    def owner_with_name
      match = owner.to_s.match(CLASS_FORMAT)
      separator = is_module ? '.' : '#'
      match ? "#{match[1]}#{separator}#{name}" : "#{owner}#{separator}#{name}"
    end
  end
end
