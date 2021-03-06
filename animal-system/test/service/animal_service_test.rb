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

  # 期待値: idとinfoがupdateメソッドに渡っていること
  test "updateメソッドの動作を担保する" do 
    animal_record = MiniTest::Mock.new
    animal_record.expect :attributes, { id: 1, name: "xxx" }

    animal_repo = MiniTest::Mock.new
    animal_repo.expect :update, true, [{id: 1, info: { id: 1, name: "xxx" } }]
    animal_repo.expect :find, animal_record, [{id: 1}]

    service = AnimalService.new(animal_repo: animal_repo)

    record = service.update(id: 1, info: { id: 1, name: "xxx" })

    assert_equal 1,  record[:id]
    assert_equal "xxx", record[:name]

    animal_repo.verify
    animal_record.verify
  end

  # 期待値: infoがcreateメソッドに渡っていること
  test "createメソッドの動作を担保する" do 
    animal_repo = MiniTest::Mock.new
    animal_repo.expect :create, { id: 1, name: "xxx" }, [{info: { id: 1, name: "xxx" } }]

    service = AnimalService.new(animal_repo: animal_repo)

    record = service.create(info: { id: 1, name: "xxx" })

    assert_equal "xxx", record[:name]
    assert_equal "xxx", record[:name]

    animal_repo.verify
  end
end