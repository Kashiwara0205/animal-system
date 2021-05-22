require "test_helper"
require "minitest/autorun"

class AnimalTypeRepositoryTest < ActiveSupport::TestCase
  # 期待値: - DBからデータが取得出来ること
  #        - 返却されるレコードデータの検証
  test "getメソッドで帰ってくる要素を担保する" do
    records = AnimalTypeRepository.get()

    assert_equal 6, records.size

    assert_equal "AMPHIBANS", records[0].name
    assert_equal "BIRDS", records[1].name
    assert_equal "FISH", records[2].name
    assert_equal "INVERTEBRATES", records[3].name
    assert_equal "MAMMALS", records[4].name
    assert_equal "REPTILE", records[5].name
  end
end
