require 'test_helper'
require "minitest/autorun"

class AnimalsControllerTest  < ActionDispatch::IntegrationTest

  # 期待値: - コントローラから期待するデータが帰ってくること
  #        - status-code 200
  test "animal_typesアクションからデータを取得する" do
    Pokotarou.execute("./test/test_data/animal_types.yml")

    get "/api/v1/animals/animal_types"
    assert_response 200
    res = JSON.parse(response.body)

    assert_equal 6, res.size
    assert_equal "両生類", res[0]["value"]
    assert_equal "鳥類", res[1]["value"]
    assert_equal "魚類", res[2]["value"]
    assert_equal "無脊椎動物", res[3]["value"]
    assert_equal "哺乳類", res[4]["value"]
    assert_equal "爬虫類", res[5]["value"]
  end

  # 期待値: - エラー内容のー返却 
  #        - status-code 500
  test "animal_typesアクションでエラーが発生したら500が発生することを担保" do
    Pokotarou.execute("./test/test_data/animal_types.yml")
    service = AnimalTypeService.new(animal_type_repo: AnimalTypeRepository)

    mock = MiniTest::Mock.new
    mock.expect(:get_selectable_elements, []) do raise StandardError.new('DummyError'); end

    AnimalTypeService.stub(:new, mock) do 
      get "/api/v1/animals/animal_types"
      assert_response 500
      res = JSON.parse(response.body)
      assert_equal "DummyError", res["error"]
    end
  end
end