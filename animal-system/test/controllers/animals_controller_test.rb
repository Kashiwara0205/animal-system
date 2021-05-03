require 'test_helper'
require "minitest/autorun"

class AnimalsControllerTest  < ActionDispatch::IntegrationTest

  # 期待値: - コントローラから期待するデータが帰ってくること
  #        - status-code 200
  test "get /api/v1/animals/animal_types アクションからデータを取得する" do
    Pokotarou.execute("./test/test_data/animal_types.yml")

    get "/api/v1/animals/animal_types"
    assert_response 200
    res = JSON.parse(response.body)

    assert_equal 6, res.size

    assert_equal "両生類", res[0]["label"]
    assert_equal "AMPHIBANS", res[0]["value"]

    assert_equal "鳥類", res[1]["label"]
    assert_equal "BIRDS", res[1]["value"]

    assert_equal "魚類", res[2]["label"]
    assert_equal "FISH", res[2]["value"]

    assert_equal "無脊椎動物", res[3]["label"]
    assert_equal "INVERTEBRATES", res[3]["value"]

    assert_equal "哺乳類", res[4]["label"]
    assert_equal "MAMMALS", res[4]["value"]

    assert_equal "爬虫類", res[5]["label"]
    assert_equal "REPTILE", res[5]["value"]
  end

  # 期待値: - エラー内容のー返却 
  #        - status-code 500
  test "get /api/v1/animals/animal_types でエラーが発生したら500が発生することを担保" do
    Pokotarou.execute("./test/test_data/animal_types.yml")

    mock = MiniTest::Mock.new
    mock.expect(:get_selectable_elements, []) do raise StandardError.new('DummyError'); end

    AnimalTypeService.stub(:new, mock) do 
      get "/api/v1/animals/animal_types"
      assert_response 500
      res = JSON.parse(response.body)
      assert_equal "DummyError", res["error"]
    end
  end

  # 期待値: - コントローラから期待するデータが帰ってくること
  #        - status-code 200
  test "get /api/v1/animals アクションからデータを取得する" do
    Pokotarou.execute("./test/test_data/animals.yml")

    get "/api/v1/animals", params: {offset: 0, limit: 50, query: {} }

    assert_response 200
    res = JSON.parse(response.body)

    info = res["info"]
    count = res["count"]

    assert_equal 10, count

    assert_equal "犬_0", info[0]["name"]
    assert_equal 10,      info[0]["weight"]
    assert_equal 111,     info[0]["height"]
    assert_equal "small", info[0]["body"]
    assert_equal "none",  info[0]["hair"]
    assert_equal "MAMMALS",  info[0]["type_name"]
    assert_equal "CHINA",  info[0]["countory_name"]
  end

  # 期待値: - エラー内容のー返却 
  #        - status-code 500
  test "get /api/v1/animals でエラーが発生したら500が発生することを担保" do
    Pokotarou.execute("./test/test_data/animals.yml")

    mock = MiniTest::Mock.new
    mock.expect(:get, []) do raise StandardError.new('DummyError'); end

    AnimalService.stub(:new, mock) do 
      get "/api/v1/animals"
      assert_response 500
      res = JSON.parse(response.body)
      assert_equal "DummyError", res["error"]
    end
  end
end