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

    assert_equal "犬_0",  info[0]["name"]
    assert_equal 10,      info[0]["weight"]
    assert_equal 111,     info[0]["height"]
    assert_equal "small", info[0]["body"]
    assert_equal "none",  info[0]["hair"]
    assert_equal 1,       info[0]["animal_type_id"]
    assert_equal 2,       info[0]["countory_id"]
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

  # 期待値: - 期待する内容でデータが更新されること
  #        - status-code 200
  test "put /api/v1/animals アクションでデータを更新する" do 
    Pokotarou.execute("./test/test_data/animals.yml")

    params =  { 
      id: 1, 
      animal: {
        name: "update-name",
        weight: 0,
        height: 0,
        hair: "short"
      } 
    }

    put "/api/v1/animals", params: params

    assert_response 200

    res = JSON.parse(response.body)
    assert_equal "update-name", res["updated_record"]["name"]
    assert_equal 0, res["updated_record"]["weight"]
    assert_equal 0, res["updated_record"]["height"]
    assert_equal "short", res["updated_record"]["hair"]

    record = Animal.find(1)
    assert_equal "update-name", record.name
    assert_equal 0, record.weight
    assert_equal 0, record.height
    assert_equal "short", record.hair
  end

  # 期待値: - エラー内容のー返却 
  #        - status-code 500
  test "put /api/v1/animals アクションでエラーが発生したら500が発生することを担保" do
    Pokotarou.execute("./test/test_data/animals.yml")

    mock = MiniTest::Mock.new
    mock.expect(:update, []) do raise StandardError.new('DummyError'); end

    AnimalService.stub(:new, mock) do 

      params =  { 
        id: 1, 
        animal: {
          name: "update-name",
          weight: 0,
          height: 0,
          hair: "short"
        } 
      }

      put "/api/v1/animals", params: params
      assert_response 500
      res = JSON.parse(response.body)
      assert_equal "DummyError", res["error"]
    end
  end
end