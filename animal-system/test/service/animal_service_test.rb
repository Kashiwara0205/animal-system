require "test_helper"
require "minitest/autorun"

class AnimalServiceTest < ActiveSupport::TestCase
  # 期待値: - attributesメソッドが叩かれていること
  #        - repositoryのgetメソッドが叩かれていること
  test "get_selectable_elementsメソッドの動作を担保する" do
    animal_record = MiniTest::Mock.new
    animal_record.expect :attributes, { id: 1, name: "animalA" }

    animal_repo = MiniTest::Mock.new
    animal_repo.expect :get, [animal_record], [{limit: 0, offset: 50, query: {}}]

    service = AnimalService.new(animal_repo: animal_repo)

    info = service.get(limit: 0, offset: 50, query: {})

    assert_equal 1, info.size
    assert_equal 1, info[0][:id]
    assert_equal "animalA", info[0][:name]

    animal_record.verify
    animal_repo.verify
  end
end