# frozen_string_literal: true

require_relative 'support/dummy/independence'
require_relative 'support/dummy/dependence_on_other_class'
require_relative 'support/dummy/dependence_on_multiple_class'

RSpec.describe TraceLocation do
  it 'has a version number' do
    expect(TraceLocation::VERSION).not_to be nil
  end

  describe '.trace' do
    before do
      TraceLocation.config.dest_dir = 'spec/support/logs'
    end

    context 'when the method is called not depending on other class' do
      let(:log_file) { Dir.entries('spec/support/logs/').select { |file_name| file_name.match?(/\.md/) }.last }
      let(:content) { File.read File.join('spec', 'support', 'logs', log_file) }
      let(:method) { Independence.method(:independent_method) }

      before do
        TraceLocation.trace { method.call }
      end

      it 'including correct path' do
        path, lineno = method.source_location
        path = path.delete_prefix "#{Dir.pwd}/"

        expect(content).to include "#{path}:#{lineno}"
      end

      it 'including method name' do
        method_name = method.name

        expect(content).to include "def self.#{method_name}"
      end
    end

    context 'when the method is called depending on other class' do
      let(:log_file) { Dir.entries('spec/support/logs/').select { |file_name| file_name.match?(/\.md/) }.last }
      let(:content) { File.read File.join('spec', 'support', 'logs', log_file) }
      let(:method) { DependenceOnOtherClass.method(:dependent_method) }
      let(:depended_method) { Independence.method(:independent_method) }

      before do
        TraceLocation.trace { method.call }
      end

      it 'including path of target method' do
        path, lineno = method.source_location
        path = path.delete_prefix "#{Dir.pwd}/"

        expect(content).to include "#{path}:#{lineno}"
      end

      it 'including method name of target method' do
        method_name = method.name

        expect(content).to include "def self.#{method_name}"
      end

      it 'including path of depended method' do
        path, lineno = depended_method.source_location
        path = path.delete_prefix "#{Dir.pwd}/"

        expect(content).to include "#{path}:#{lineno}"
      end

      it 'including method name of dependent method' do
        method_name = depended_method.name

        expect(content).to include "def self.#{method_name}"
      end
    end

    context 'with "match"' do
      let(:log_file) { Dir.entries('spec/support/logs/').select { |file_name| file_name.match?(/\.md/) }.last }
      let(:content) { File.read File.join('spec', 'support', 'logs', log_file) }

      context 'when argument is kind of Array' do
        let(:method) { DependenceOnOtherClass.method(:dependent_method) }
        let(:method_between_other_methods) { DependenceOnOtherClass.method(:dependent_method) }
        let(:depended_method) { Independence.method(:independent_method) }

        before do
          TraceLocation.trace(match: [:dependence_on_other_class, 'dependence_on_multiple_class']) { method.call }
        end

        it 'including path of target method' do
          path, lineno = method.source_location
          path = path.delete_prefix "#{Dir.pwd}/"

          expect(content).to include "#{path}:#{lineno}"
        end

        it 'including method name of target method' do
          method_name = method.name

          expect(content).to include "def self.#{method_name}"
        end

        it 'including path of method between other methods' do
          path, lineno = method_between_other_methods.source_location
          path = path.delete_prefix "#{Dir.pwd}/"

          expect(content).to include "#{path}:#{lineno}"
        end

        it 'including method name of method between other methods' do
          method_name = method_between_other_methods.name

          expect(content).to include "def self.#{method_name}"
        end

        it 'excluding path of depended method' do
          path, lineno = depended_method.source_location
          path = path.delete_prefix "#{Dir.pwd}/"

          expect(content).not_to include "#{path}:#{lineno}"
        end

        it 'excluding method name of depended method' do
          method_name = depended_method.name

          expect(content).not_to include "def self.#{method_name}"
        end
      end

      context 'when argument is not kind of Array' do
        let(:method) { DependenceOnOtherClass.method(:dependent_method) }
        let(:depended_method) { Independence.method(:independent_method) }

        before do
          TraceLocation.trace(match: /dependence_on_other_class/) { method.call }
        end

        it 'including path of target method' do
          path, lineno = method.source_location
          path = path.delete_prefix "#{Dir.pwd}/"

          expect(content).to include "#{path}:#{lineno}"
        end

        it 'including method name of target method' do
          method_name = method.name

          expect(content).to include "def self.#{method_name}"
        end

        it 'excluding path of depended method' do
          path, lineno = depended_method.source_location
          path = path.delete_prefix "#{Dir.pwd}/"

          expect(content).not_to include "#{path}:#{lineno}"
        end

        it 'excluding method name of depended method' do
          method_name = depended_method.name

          expect(content).not_to include "def self.#{method_name}"
        end
      end
    end

    context 'with "ignore"' do
      let(:log_file) { Dir.entries('spec/support/logs/').select { |file_name| file_name.match?(/\.md/) }.last }
      let(:content) { File.read File.join('spec', 'support', 'logs', log_file) }

      context 'when argument is kind of Array' do
        let(:method) { DependenceOnMultipleClass.method(:dependent_method) }
        let(:method_between_other_methods) { DependenceOnOtherClass.method(:dependent_method) }
        let(:depended_method) { Independence.method(:independent_method) }

        before do
          TraceLocation.trace(ignore: [:dependence_on_other_class, 'dependence_on_multiple_class']) { method.call }
        end

        it 'excluding path of called method' do
          path, lineno = method.source_location
          path = path.delete_prefix "#{Dir.pwd}/"

          expect(content).not_to include "#{path}:#{lineno}"
        end

        it 'excluding method name of target method' do
          method_name = method.name

          expect(content).not_to include "def self.#{method_name}"
        end

        it 'excluding path of method between other methods' do
          path, lineno = method_between_other_methods.source_location
          path = path.delete_prefix "#{Dir.pwd}/"

          expect(content).not_to include "#{path}:#{lineno}"
        end

        it 'excluding method name of method between other methods' do
          method_name = method_between_other_methods.name

          expect(content).not_to include "def self.#{method_name}"
        end

        it 'including path of depended method' do
          path, lineno = depended_method.source_location
          path = path.delete_prefix "#{Dir.pwd}/"

          expect(content).to include "#{path}:#{lineno}"
        end

        it 'including method name of depended method' do
          method_name = depended_method.name

          expect(content).to include "def self.#{method_name}"
        end
      end

      context 'when argument is not kind of Array' do
        let(:method) { DependenceOnOtherClass.method(:dependent_method) }
        let(:depended_method) { Independence.method(:independent_method) }

        before do
          TraceLocation.trace(ignore: /dependence_on_other_class/) { method.call }
        end

        it 'excluding path of target method' do
          path, lineno = method.source_location
          path = path.delete_prefix "#{Dir.pwd}/"

          expect(content).not_to include "#{path}:#{lineno}"
        end

        it 'excluding method name of target method' do
          method_name = method.name

          expect(content).not_to include "def self.#{method_name}"
        end

        it 'including path of depended method' do
          path, lineno = depended_method.source_location
          path = path.delete_prefix "#{Dir.pwd}/"

          expect(content).to include "#{path}:#{lineno}"
        end

        it 'including method name of depended method' do
          method_name = depended_method.name

          expect(content).to include "def self.#{method_name}"
        end
      end
    end

    context 'with "format"' do
      context 'with "markdown"' do
        let(:log_file) { Dir.entries('spec/support/logs/').select { |file_name| file_name.match?(/\.md/) }.last }
        let(:content) { File.read File.join('spec', 'support', 'logs', log_file) }
        let(:method) { Independence.method(:independent_method) }

        before do
          TraceLocation.trace(format: :markdown) { method.call }
        end

        it 'including correct path' do
          path, lineno = method.source_location
          path = path.delete_prefix "#{Dir.pwd}/"

          expect(content).to include "#{path}:#{lineno}"
        end

        it 'including method name' do
          method_name = method.name

          expect(content).to include "def self.#{method_name}"
        end
      end

      context 'with "md"' do
        let(:log_file) { Dir.entries('spec/support/logs/').select { |file_name| file_name.match?(/\.md/) }.last }
        let(:content) { File.read File.join('spec', 'support', 'logs', log_file) }
        let(:method) { Independence.method(:independent_method) }

        before do
          TraceLocation.trace(format: :md) { method.call }
        end

        it 'including correct path' do
          path, lineno = method.source_location
          path = path.delete_prefix "#{Dir.pwd}/"

          expect(content).to include "#{path}:#{lineno}"
        end

        it 'including method name' do
          method_name = method.name

          expect(content).to include "def self.#{method_name}"
        end
      end

      context 'with html' do
        let(:log_file) { Dir.entries('spec/support/logs').select { |file_name| file_name.match?(/\.html/) }.last }
        let(:content) { File.read File.join('spec', 'support', 'logs', log_file) }
        let(:method) { Independence.method(:independent_method) }

        before do
          TraceLocation.trace(format: :html) { method.call }
        end

        it 'including html tag' do
          expect(content).to include "<html>"
        end

        it 'including path of target method' do
          path, lineno = method.source_location
          path = path.delete_prefix "#{Dir.pwd}/"

          expect(content).to include "#{path}:#{lineno}"
        end

        it 'including method name' do
          method_name = method.name

          expect(content).to include "#{method_name}"
        end
      end

      context 'with "log"' do
        let(:log_file) { Dir.entries('spec/support/logs/').select { |file_name| file_name.match?(/\.log/) }.last }
        let(:content) { File.read File.join('spec', 'support', 'logs', log_file) }
        let(:method) { Independence.method(:independent_method) }

        before do
          TraceLocation.trace(format: :log) { method.call }
        end

        it 'including path of target method' do
          path, lineno = method.source_location
          path = path.delete_prefix "#{Dir.pwd}/"

          expect(content).to include "#{path}:#{lineno}"
        end

        it 'including method calling' do
          method_calling = method.to_s.gsub(/#<Method: |>/, '')

          expect(content).to include "[#{method_calling}]"
        end
      end

      context 'with "csv"' do
        let(:log_file) { Dir.entries('spec/support/logs/').select { |file_name| file_name.match?(/\.csv/) }.last }
        let(:content) { File.read File.join('spec', 'support', 'logs', log_file) }
        let(:csv_header) { "id,event,path,lineno,caller_path,caller_lineno,owner_with_name,hierarchy\n" }
        let(:method) { Independence.method(:independent_method) }

        before do
          TraceLocation.trace(format: :csv) { method.call }
        end

        it 'including header' do
          expect(content).to include csv_header
        end

        it 'including path of target method' do
          path, lineno = method.source_location
          path = path.delete_prefix "#{Dir.pwd}/"

          expect(content).to include "#{path},#{lineno}"
        end

        it 'including method calling' do
          method_calling = method.to_s.gsub(/#<Method: |>/, '')

          expect(content).to include method_calling.to_s
        end
      end
    end

    after do
      Dir.foreach('spec/support/logs') do |file_name|
        FileUtils.rm File.join('spec', 'support', 'logs', file_name), force: true
      end
    end
  end
end
