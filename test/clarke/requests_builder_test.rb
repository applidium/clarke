# frozen_string_literal: true

require './test/test_helper'

class TestClarkeRequestsBuilder < Test::Unit::TestCase
  module Clarke::RequestsBuilder::Action1
    def self.valid?(*)
      false
    end

    def self.build_requests(_message)
      'action1'
    end
  end

  module Clarke::RequestsBuilder::Action2
    def self.valid?(*)
      true
    end

    def self.build_requests(_message)
      'action2'
    end
  end

  module Clarke::RequestsBuilder::MissingMethodValidAction
    def self.build_requests(_message)
      'action2'
    end
  end

  module Clarke::RequestsBuilder::MissingMethodBuildRequests
    def self.valid?(*)
      true
    end
  end

  teardown do
    Clarke::RequestsBuilder.clear!
  end

  test 'configure no strategies' do
    assert_empty Clarke::RequestsBuilder.request_builders
  end

  test 'configure a valid strategy' do
    assert_not_empty Clarke::RequestsBuilder.config([Clarke::RequestsBuilder::Action1])
  end

  test 'raise error if I add a strategy that does not have an valid? method' do
    assert_raise NoMethodError do
      Clarke::RequestsBuilder.config([Clarke::RequestsBuilder::MissingMethodValidAction])
    end
  end

  test 'raise error if I add a strategy that does not have an build_requests method' do
    assert_raise NoMethodError do
      Clarke::RequestsBuilder.config([Clarke::RequestsBuilder::MissingMethodBuildRequests])
    end
  end

  test 'return result of a correct requests builder' do
    Clarke::RequestsBuilder.config([Clarke::RequestsBuilder::Action2])
    assert_equal(['action2'], Clarke::RequestsBuilder.build_action_requests(nil))
  end

  test 'return nil if there is no correct requests builder' do
    Clarke::RequestsBuilder.config([Clarke::RequestsBuilder::Action1])
    assert_empty Clarke::RequestsBuilder.build_action_requests(nil)
  end
end
