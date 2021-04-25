require "test_helper"
require "minitest/autorun"

class CountoryRepositoryTest < ActiveSupport::TestCase
  # 期待値: - DBからデータが取得出来ること
  #        - 返却されるレコードデータの検証
  test "getメソッドで帰ってくる要素を担保する" do
    Pokotarou.execute("./test/test_data/countories.yml")
    records = CountoryRepository.get()

    assert_equal 8, records.size

    assert_equal "BELIZE", records[0].name
    assert_equal "BENIN", records[1].name
    assert_equal "CHILE", records[2].name
    assert_equal "CHINA", records[3].name
    assert_equal "FRANCE", records[4].name
    assert_equal "GABON", records[5].name
    assert_equal "INDIA", records[6].name
    assert_equal "JAPAN", records[7].name
  end
end
