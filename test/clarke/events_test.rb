require "./test/test_helper"

class TestClarkeEvents < Test::Unit::TestCase

  setup do
  end

  module Clarke::Test1
    class TextMessage
      include Clarke::Events::TextMessage
    end
  end

  module Clarke::Test2
    class TextMessage
      include Clarke::Events::TextMessage
      def sender;end
      def text;end
    end
  end

  test 'not implemented sender method' do
    assert_raise NotImplementedError do
      Clarke::Test1::TextMessage.new().sender()
    end
  end

  test 'not implemented text method' do
    assert_raise NotImplementedError do
      Clarke::Test1::TextMessage.new().text()
    end
  end

  test 'implemented sender method' do
    assert_nothing_raised do
      Clarke::Test2::TextMessage.new().sender()
    end
  end

  test 'implemented text method' do
    assert_nothing_raised do
      Clarke::Test2::TextMessage.new().text()
    end
  end

end
