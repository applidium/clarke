# frozen_string_literal: true

module Clarke
  module Events
    module TextMessage
      include Events::Base

      def method_missing(m, *args, &block)
        case m
        when :text then raise NotImplementedError, m
        end
        super(m, *args, &block)
      end
    end
  end
end
