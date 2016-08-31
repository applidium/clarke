module Clarke
  class ActionRequest
    attr_reader :action, :event, :options

    def initialize(action, event, options = {})
      @action = action
      @event = event
      @options = options
    end
  end
end
