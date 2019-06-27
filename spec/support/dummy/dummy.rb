# frozen_string_literal: true

class DummyA
  def dummy
    p "It's a dummy method"
  end
end

class DummyB
  def dummy
    DummyA.new.dummy
  end
end
