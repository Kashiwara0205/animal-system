require 'test_helper'
require "minitest/autorun"

class CountoriesControllerTest  < ActionDispatch::IntegrationTest

  # 期待値: - コントローラから期待するデータが帰ってくること
  #        - status-code 200
  test "countoriesアクションからデータを取得する" do
    get "/api/v1/countories"
    assert_response 200
    res = JSON.parse(response.body)

    assert_equal 8, res.size

    assert_equal "ベリーズ", res[0]["label"]
    assert_equal "BELIZE", res[0]["value"]

    assert_equal "ベナン", res[1]["label"]
    assert_equal "BENIN", res[1]["value"]

    assert_equal "チリ", res[2]["label"]
    assert_equal "CHILE", res[2]["value"]

    assert_equal "中国", res[3]["label"]
    assert_equal "CHINA", res[3]["value"]

    assert_equal "フランス", res[4]["label"]
    assert_equal "FRANCE", res[4]["value"]

    assert_equal "ガボン", res[5]["label"]
    assert_equal "GABON", res[5]["value"]

    assert_equal "インド", res[6]["label"]
    assert_equal "INDIA", res[6]["value"]

    assert_equal "日本", res[7]["label"]
    assert_equal "JAPAN", res[7]["value"]
  end

  # 期待値: - エラー内容のー返却 
  #        - status-code 500
  test "countoriesアクションでエラーが発生したら500が発生することを担保" do
    Pokotarou.execute("./test/test_data/countories.yml")
    service = CountoryService.new(countory_repo: CountoryRepository)

    mock = MiniTest::Mock.new
    mock.expect(:get_selectable_elements, []) do raise StandardError.new('DummyError'); end

    CountoryService.stub(:new, mock) do 
      get "/api/v1/countories"
      assert_response 500
      res = JSON.parse(response.body)
      assert_equal "DummyError", res["errors"]
    end
  end
end