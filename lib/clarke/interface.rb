module Clarke
  class << self

    def process (ui_module, request_body)
      events = Array(ui_module.parse(request_body))
      events.map do |event|
        Clarke::RequestsBuilder::build_action_requests(event).map do |action_request|
          responses = Clarke::ActionController::process(action_request)
          ui_module.deliver(responses)
        end
      end.flatten
    end
  end
end
