require "./test/test_helper"

class TestClarkeActionController < Test::Unit::TestCase

  teardown do
    Clarke::ActionController.clear_actions!
  end

  test 'has not actions' do
    assert_empty Clarke::ActionController.send(:actions)
  end

  test 'add a valid action' do
    module Clarke::ActionController
      action 'hello' do
        'hello'
      end
    end
    assert_not_empty Clarke::ActionController.send(:actions)
  end

  test 'raise missing_action' do
    assert_raise NoMethodError do
      Clarke::ActionController.process({action: 'no_action'})
    end
  end

  test 'return hello when calling helloaction' do
    module Clarke::ActionController
      action 'hello' do
        'hello'
      end
    end
    action_request = Clarke::ActionRequest.new('hello', nil)
    assert_equal ['hello'], Clarke::ActionController.process(action_request)
  end

  test 'access options inside action' do
    module Clarke::ActionController
      action 'hello' do
        options[:response]
      end
    end
    action_request = Clarke::ActionRequest.new('hello', nil, {response: 'hi!'})
    assert_equal ['hi!'], Clarke::ActionController.process(action_request)
  end

end
