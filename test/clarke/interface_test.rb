require "./test/test_helper"

class TestClarkeInterface < Test::Unit::TestCase
  module Clarke::Fake
    class TextMessage
      include Clarke::Events::TextMessage
      attr_accessor :sender, :text

      def initialize(text)
        @text = text
      end
    end

    class << self
      def parse(request_body)
        [TextMessage.new(request_body + ' event 1'), TextMessage.new(request_body + ' event 2')]
      end

      def send(responses)
        responses.map(&:text)
      end
    end
  end

  module Clarke::RequestsBuilder::TextEcho
    def self.valid?(_) true end
    def self.build_requests(event)
      [Clarke::ActionRequest.new('text_echo', event, {text: event.text + ' AR 1'}), Clarke::ActionRequest.new('text_echo', event, {text: event.text + ' AR 2'})]
    end
  end

  teardown do
    Clarke::ActionController.clear_actions!
  end

  test 'process' do
    Clarke::RequestsBuilder.config([Clarke::RequestsBuilder::TextEcho])
    module Clarke::ActionController
      action 'text_echo' do
        Clarke::Response.new(options[:event].sender, {text: options[:text]})
      end
    end

    assert_equal ['input event 1 AR 1', 'input event 1 AR 2', 'input event 2 AR 1', 'input event 2 AR 2'], Clarke.process(Clarke::Fake, "input")
  end
end
