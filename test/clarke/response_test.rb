# frozen_string_literal: true

require './test/test_helper'

class TestClarkeResponse < Test::Unit::TestCase
  setup do
  end

  test 'create an empty response' do
    response = Clarke::Response.new('abc123')
    assert_equal('abc123', response.recipient)
  end

  test 'create a response with text' do
    response = Clarke::Response.new('abc123', text: 'hello')
    assert_equal('abc123', response.recipient)
    assert_equal('hello', response.text)
  end

  test 'to json' do
    response = Clarke::Response.new('abc123', text: 'hello')
    assert_equal('{"recipient":"abc123","options":{"text":"hello"}}', response.to_json)
  end

  test 'from json' do
    response = Clarke::Response.from_json('{"recipient":"abc123","options":{"text":"hello"}}')
    assert_equal 'abc123', response.recipient
    assert_equal 'hello', response.options[:text]
  end
end
