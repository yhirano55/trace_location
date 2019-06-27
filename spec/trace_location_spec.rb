# frozen_string_literal: true

require 'fileutils'
require_relative 'support/dummy/dummy'

RSpec.describe TraceLocation do
  it 'has a version number' do
    expect(TraceLocation::VERSION).not_to be nil
  end

  describe '.trace' do
    before do
      TraceLocation.config.dest_dir = 'spec/support/logs'
    end

    context 'when a method is ca' do
      dummy_instance = DummyA.new

      let(:log_file) { Dir.entries('spec/support/logs/').select { |file_name| file_name.match?(/\.md/) }.last }
      let(:content) { File.read File.join('spec', 'support', 'logs', log_file) }

      before do
        TraceLocation.trace { dummy_instance.dummy }
      end

      it 'including correct path' do
        path, lineno = dummy_instance.method(:dummy).source_location
        path = path.delete_prefix "#{Dir.pwd}/"

        expect(content).to include "#{path}:#{lineno}"
      end

      it 'including method name' do
        name = dummy_instance.method(:dummy).name

        expect(content).to include "def #{name}"
      end
    end

    context 'when the method is called depending on other' do
      dummy_instance_a = DummyA.new
      dummy_instance_b = DummyB.new

      let(:log_file) { Dir.entries('spec/support/logs/').select { |file_name| file_name.match?(/\.md/) }.last }
      let(:content) { File.read File.join('spec', 'support', 'logs', log_file) }

      before do
        TraceLocation.trace { dummy_instance_b.dummy }
      end

      it 'including path of DummyA.dummy' do
        path, lineno = dummy_instance_b.method(:dummy).source_location
        path = path.delete_prefix "#{Dir.pwd}/"

        expect(content).to include "#{path}:#{lineno}"
      end

      it 'including path of DummyB.dummy' do
        path, lineno = dummy_instance_b.method(:dummy).source_location
        path = path.delete_prefix "#{Dir.pwd}/"

        expect(content).to include "#{path}:#{lineno}"
      end

      it 'including method name of DummyA.dummy' do
        name = dummy_instance_a.method(:dummy).name

        expect(content).to include "def #{name}"
      end

      it 'including method name of DummyB.dummy' do
        name = dummy_instance_b.method(:dummy).name

        expect(content).to include "def #{name}"
      end
    end

    after do
      Dir.foreach('spec/support/logs') do |file_name|
        FileUtils.rm File.join('spec', 'support', 'logs', file_name), force: true
      end
    end
  end
end
