# frozen_string_literal: true

module Clarke
  module ActionController
    class << self
      @actions = {}

      def process(action_request)
        action = actions[action_request.action]
        if action
          @options = set_options(action_request)
          responses = action.call
          return Array(responses)
        else
          raise NoMethodError, "#{action_request.action} not found"
        end
      end

      def action(name, &block)
        puts "Add action : #{name}"
        actions[name] = block
      end

      def clear_actions!
        @actions = {}
      end

      private

      def actions
        @actions ||= {}
      end

      def set_options(action_request)
        @options = action_request.options.merge(
          action: action_request.action,
          event: action_request.event
        )
      end

      def options
        @options ||= {}
      end
    end
  end
end
