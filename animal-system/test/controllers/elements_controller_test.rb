require 'test_helper'
require "minitest/autorun"

class ElementsControllerTest  < ActionDispatch::IntegrationTest

  # 期待値: - コントローラから期待するデータが帰ってくること
  #        - status-code 200
  test "animal_typesアクションからデータを取得する" do
    Pokotarou.execute("./test/test_data/animal_types.yml")

    get "/api/v1/elements/animal_types"
    assert_response 200
    res = JSON.parse(response.body)

    assert_equal 6, res.size
    assert_equal "AMPHIBANS", res[0]["value"]
    assert_equal "BIRDS", res[1]["value"]
    assert_equal "FISH", res[2]["value"]
    assert_equal "INVERTEBRATES", res[3]["value"]
    assert_equal "MAMMALS", res[4]["value"]
    assert_equal "REPTILE", res[5]["value"]
  end

  # 期待値: - エラー内容のー返却 
  #        - status-code 500
  test "animal_typesアクションでエラーが発生したら500が発生することを担保" do
    Pokotarou.execute("./test/test_data/animal_types.yml")
    service = AnimalTypeService.new(animal_type_repo: AnimalTypeRepository)

    mock = MiniTest::Mock.new
    mock.expect(:get_selectable_elements, []) do raise StandardError.new('DummyError'); end

    AnimalTypeService.stub(:new, mock) do 
      get "/api/v1/elements/animal_types"
      assert_response 500
      res = JSON.parse(response.body)
      assert_equal "DummyError", res["error"]
    end
  end
end