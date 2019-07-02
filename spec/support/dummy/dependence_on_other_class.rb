# frozen_string_literal: true

class DependenceOnOtherClass
  def self.dependent_method
    Independence.independent_method
  end
end
