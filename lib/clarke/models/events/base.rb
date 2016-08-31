module Clarke
  module Events
    module Base

      # Raise error if methods are not overided in Event Classes in UI libs
      def method_missing(m, *args, &block)
        case m
        when :sender then raise NotImplementedError, m
        end
        super(m, *args, &block)
      end

    end
  end
end
