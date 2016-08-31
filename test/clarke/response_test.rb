require "./test/test_helper"

class TestClarkeResponse < Test::Unit::TestCase

  setup do
  end

  test "create an empty response" do
    response = Clarke::Response.new('abc123')
    assert_equal('abc123', response.recipient)
  end

  test "create a response with text" do
    response = Clarke::Response.new('abc123', {text: 'hello'})
    assert_equal('abc123', response.recipient)
    assert_equal('hello', response.text)
  end

end
