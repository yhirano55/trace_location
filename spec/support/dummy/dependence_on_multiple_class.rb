# frozen_string_literal: true

class DependenceOnMultipleClass
  def self.dependent_method
    DependenceOnOtherClass.dependent_method
  end
end
