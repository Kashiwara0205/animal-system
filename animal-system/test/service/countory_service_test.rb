require "test_helper"
require "minitest/autorun"

class CountoryServiceTest < ActiveSupport::TestCase
  # 期待値: - key, valueの値で要素が帰ってくること
  #        - repositoryのgetメソッドが叩かれていること
  test "get_selectable_elementsメソッドの動作を担保する" do
    countory_record = MiniTest::Mock.new
    countory_record.expect :id, 1
    countory_record.expect :name, "JAPAN"

    countory_repo = MiniTest::Mock.new
    countory_repo.expect :get, [countory_record]

    service = CountoryService.new(countory_repo: countory_repo)

    elements = service.get_selectable_elements()

    assert_equal 1, elements.size
    assert_equal 1, elements[0][:key]
    assert_equal "日本", elements[0][:label]
    assert_equal "JAPAN", elements[0][:value]

    countory_record.verify
    countory_repo.verify
  end
end
