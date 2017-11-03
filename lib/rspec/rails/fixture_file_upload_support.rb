module RSpec
  module Rails
    # @private
    module FixtureFileUploadSupport
      module_function

      def included(other)
        other.include ActionDispatch::TestProcess if defined?(ActionDispatch::TestProcess)
      end

      def fixture_file_upload
        resolved_fixture_path = File.join(fixture_path || RSpec.configuration.fixture_path || '', '')

        # Override fixture_path set
        # to support Rails 3.0->3.1 using ActionController::TestCase class to resolve fixture_path
        # see https://apidock.com/rails/v3.0.0/ActionDispatch/TestProcess/fixture_file_upload
        if ActionController::TestCase.respond_to?(:fixture_path)
          ActionController::TestCase.fixture_path = resolved_fixture_path
        end
        resolved_fixture_path
      end

    end
  end
end
