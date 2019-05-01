# frozen_string_literal: true

RSpec.describe TraceLocation do
  it 'has a version number' do
    expect(TraceLocation::VERSION).not_to be nil
  end
end
