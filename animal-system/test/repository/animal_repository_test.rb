require "test_helper"
require "minitest/autorun"

class AnimalRepositoryTest < ActiveSupport::TestCase
  # 期待値: - DBからデータが取得出来ること
  #        - 返却されるレコードデータの検証
  test "getメソッドで帰ってくる要素を担保する" do
    Pokotarou.execute("./test/test_data/animals.yml")
    records = AnimalRepository.get(limit: 50, offset: 0, query: {})

    assert_equal 10, records.size
  end

  # 期待値: - limitとoffsetで指定したデータ数の返却
  test "getメソッドのoffset指定が効いている事を担保する" do
    Pokotarou.execute("./test/test_data/animals.yml")
    records = AnimalRepository.get(limit: 1, offset: 0, query: {})

    assert_equal 1, records.size

    records = AnimalRepository.get(limit: 5, offset: 0, query: {})

    assert_equal 5, records.size

    records = AnimalRepository.get(limit: 10, offset: 5, query: {})

    assert_equal 5, records.size
  end
end
