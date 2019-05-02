# frozen_string_literal: true

module Clarke
  module RequestsBuilder
    class << self
      @request_builders = []

      def config(request_builders)
        validate_request_builders(request_builders)
        @request_builders = request_builders
      end

      attr_reader :request_builders

      def clear!
        @request_builders.clear
      end

      def build_action_requests(event)
        @request_builders.each do |request_builder|
          next unless request_builder.valid?(event)

          built_request = request_builder.build_requests(event)
          return Array(built_request) if built_request
        end
        []
      end

      private

      def validate_request_builders(request_builders)
        request_builders.each { |request_builder| valid(request_builder) }
      end

      def valid(request_builder)
        unless request_builder.respond_to?(:valid?)
          raise NoMethodError, "self.valid? is not declared in the #{request_builder.name} request builder"
        end
        unless request_builder.respond_to?(:build_requests)
          raise NoMethodError, "self.build_requests is not declared in the #{request_builder.name} request builder"
        end
      end
    end
  end
end
