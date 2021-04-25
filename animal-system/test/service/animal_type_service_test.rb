require "test_helper"
require "minitest/autorun"

class AnimalTypeServiceTest < ActiveSupport::TestCase
  # 期待値: - key, valueの値で要素が帰ってくること
  #        - repositoryのgetメソッドが叩かれていること
  test "get_selectable_elementsメソッドの動作を担保する" do
    animal_type_record = MiniTest::Mock.new
    animal_type_record.expect :id, 1
    animal_type_record.expect :name, "BIRDS"

    animal_type_repo = MiniTest::Mock.new
    animal_type_repo.expect :get, [animal_type_record]

    service = AnimalTypeService.new(animal_type_repo: animal_type_repo)

    elements = service.get_selectable_elements()

    assert_equal 1, elements.size
    assert_equal 1, elements[0][:key]
    assert_equal "鳥類", elements[0][:value]

    animal_type_record.verify
    animal_type_repo.verify
  end
end
