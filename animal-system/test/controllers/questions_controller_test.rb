require 'test_helper'
require "minitest/autorun"

class QuestionsControllerTest  < ActionDispatch::IntegrationTest

  # 期待値: - コントローラから期待するデータが帰ってくること
  #        - status-code 200
  test "get /api/v1/questions アクションからデータを取得する" do
    Pokotarou.execute("./test/test_data/questions/questions.yml")

    get "/api/v1/questions"
    assert_response 200
    res = JSON.parse(response.body)

    info = res["info"]
    count = res["count"]

    assert_equal 10, count

    assert_equal 1, info[0]["id"]
    assert_equal "Aの件", info[0]["title"]
    assert_equal "new", info[0]["phase"]
    assert_equal "ACONTENT", info[0]["content"]
    assert_equal "Aさん", info[0]["member_name"]
    assert_equal "食べ物,病気・治療", info[0]["tag_name"]
  end

  # 期待値: - エラー内容のー返却 
  #        - status-code 500
  test "get /api/v1/questions でエラーが発生したら500が発生することを担保" do
    mock = MiniTest::Mock.new
    mock.expect(:get, []) do raise StandardError.new('DummyError'); end

    QuestionService.stub(:new, mock) do 
      get "/api/v1/questions"
      assert_response 500
      res = JSON.parse(response.body)
      assert_equal "DummyError", res["errors"]
    end
  end
end