require "test_helper"
require "minitest/autorun"

class AnimalServiceTest < ActiveSupport::TestCase
  # 期待値: - attributesメソッドが叩かれていること
  #        - repositoryのgetメソッドが叩かれていること
  test "get_selectable_elementsメソッドの動作を担保する" do
    animal_record = MiniTest::Mock.new
    animal_record.expect :attributes, { id: 1, name: "animalA" }

    animal_repo = MiniTest::Mock.new
    animal_repo.expect :get, [animal_record], [{limit: 0, offset: 50, query: { name_eq: "animalA" }}]
    animal_repo.expect :get_count, 1, [{query: { name_eq: "animalA" }}]

    service = AnimalService.new(animal_repo: animal_repo)

    info, count = service.get(limit: 0, offset: 50, query: { name_eq: "animalA" })

    assert_equal 1, info[0][:id]
    assert_equal "animalA", info[0][:name]

    assert_equal 1, count

    animal_record.verify
    animal_repo.verify
  end
end