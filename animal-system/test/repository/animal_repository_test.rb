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

  # 期待値: レコードのサイズが0件
  test "データが0件でも動作する事を担保する" do 
    records = AnimalRepository.get(limit: 10, offset: 5, query: {})

    assert_equal 0, records.size
  end

  # 期待値: 想定するレコードのヒット件数と一致すること
  test "動物の名前検索に関して担保する" do 
    Pokotarou.execute("./test/test_data/animals.yml")

    query = { name_cont: "犬" }
    records = AnimalRepository.get(limit: 10, offset: 0, query: query)
    assert_equal 4, records.size

    query = { name_cont: "猫" }
    records = AnimalRepository.get(limit: 10, offset: 0, query: query)
    assert_equal 3, records.size

    query = { name_cont: "犬_0" }
    records = AnimalRepository.get(limit: 10, offset: 0, query: query)
    assert_equal 1, records.size
  end

  # 期待値: 想定するレコードのヒット件数と一致すること
  test "動物の体重検索に関して担保する" do 
    Pokotarou.execute("./test/test_data/animals.yml")

    query = { weight_gteq: 100, weight_lteq: 200 }
    records = AnimalRepository.get(limit: 10, offset: 0, query: query)
    assert_equal 2, records.size

    query = { weight_gteq: 0, weight_lteq: 100 }
    records = AnimalRepository.get(limit: 10, offset: 0, query: query)
    assert_equal 10, records.size

    query = { weight_gteq: 30, weight_lteq: 50 }
    records = AnimalRepository.get(limit: 10, offset: 0, query: query)
    assert_equal 2, records.size
  end

  # 期待値: 想定するレコードのヒット件数と一致すること
  test "動物の身長検索に関して担保する" do 
    Pokotarou.execute("./test/test_data/animals.yml")

    query = { height_gteq: 100, height_lteq: 200 }
    records = AnimalRepository.get(limit: 10, offset: 0, query: query)
    assert_equal 2, records.size

    query = { height_gteq: 0, height_lteq: 100 }
    records = AnimalRepository.get(limit: 10, offset: 0, query: query)
    assert_equal 6, records.size

    query = { height_gteq: 30, height_lteq: 50 }
    records = AnimalRepository.get(limit: 10, offset: 0, query: query)
    assert_equal 1, records.size
  end

  # 期待値: 想定するレコードのヒット件数と一致すること
  test "動物の体検索に関して担保する" do 
    Pokotarou.execute("./test/test_data/animals.yml")

    query = { body_eq: "small" }
    records = AnimalRepository.get(limit: 10, offset: 0, query: query)
    assert_equal 3, records.size

    query = { body_eq: "middle" }
    records = AnimalRepository.get(limit: 10, offset: 0, query: query)
    assert_equal 5, records.size

    query = { body_eq: "large" }
    records = AnimalRepository.get(limit: 10, offset: 0, query: query)
    assert_equal 2, records.size
  end

  # 期待値: 想定するレコードのヒット件数と一致すること
  test "動物の毛の検索に関して担保する" do 
    Pokotarou.execute("./test/test_data/animals.yml")

    query = { hair_eq: "none" }
    records = AnimalRepository.get(limit: 10, offset: 0, query: query)
    assert_equal 5, records.size

    query = { hair_eq: "short" }
    records = AnimalRepository.get(limit: 10, offset: 0, query: query)
    assert_equal 3, records.size

    query = { hair_eq: "long" }
    records = AnimalRepository.get(limit: 10, offset: 0, query: query)
    assert_equal 2, records.size

    query = { hair_eq_any: ["long", "short"] }
    records = AnimalRepository.get(limit: 10, offset: 0, query: query)
    assert_equal 5, records.size
  end

  # 期待値: 想定するレコードのヒット件数と一致すること
  test "種類の検索に関して担保する" do 
    Pokotarou.execute("./test/test_data/animals.yml")

    query = { animal_type_id_eq: 1 }
    records = AnimalRepository.get(limit: 10, offset: 0, query: query)
    assert_equal 3, records.size

    query = { animal_type_id_eq: 2 }
    records = AnimalRepository.get(limit: 10, offset: 0, query: query)
    assert_equal 3, records.size

    query = { animal_type_id_eq: 3 }
    records = AnimalRepository.get(limit: 10, offset: 0, query: query)
    assert_equal 2, records.size

    query = { animal_type_id_eq_any: [1, 3] }
    records = AnimalRepository.get(limit: 10, offset: 0, query: query)
    assert_equal 5, records.size
  end

  # 期待値: 想定するレコードのヒット件数と一致すること
  test "原産国の検索に関して担保する" do 
    Pokotarou.execute("./test/test_data/animals.yml")

    query = { countory_id_eq: 1 }
    records = AnimalRepository.get(limit: 10, offset: 0, query: query)
    assert_equal 0, records.size

    query = { countory_id_eq: 2 }
    records = AnimalRepository.get(limit: 10, offset: 0, query: query)
    assert_equal 3, records.size

    query = { countory_id_eq: 3 }
    records = AnimalRepository.get(limit: 10, offset: 0, query: query)
    assert_equal 3, records.size


    query = { countory_id_eq_any: [2, 3] }
    records = AnimalRepository.get(limit: 10, offset: 0, query: query)
    assert_equal 6, records.size
  end

  # 期待値: 想定するcount値と一致すること
  test "get_countメソッドを担保する" do 
    Pokotarou.execute("./test/test_data/animals.yml")

    count = AnimalRepository.get_count( query: {})
    assert_equal 10, count

    count = AnimalRepository.get_count( query: { countory_id_eq: 1 })
    assert_equal 0, count

    count = AnimalRepository.get_count( query: { body_eq: "large"  })
    assert_equal 2, count
  end
end
