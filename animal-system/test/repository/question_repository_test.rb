require "test_helper"
require "minitest/autorun"

class QuestionRepositoryTest < ActiveSupport::TestCase

  # 期待値: - DBからデータが取得出来ること
  #        - 返却されるレコードデータの検証
  test "getメソッドで帰ってくる要素を担保する" do
    Pokotarou.execute("./test/test_data/questions/questions.yml")
    records = QuestionRepository.get(limit: 50, offset: 0, query: {})
    assert_equal 10, records.length
  end

  # 期待値: - 作成日時順であること
  #         - 未対応のものが上に来ること
  test "sort順を担保" do
    Pokotarou.execute("./test/test_data/questions/sort.yml")

    records = QuestionRepository.get(limit: 50, offset: 0, query: {})

    assert_equal 6, records.length

    assert_equal "Cの件", records[0].title
    assert_equal "new", records[0].phase
    assert_equal "2020-06-01 10:30:00 UTC", records[0].created_at.to_s

    assert_equal "Bの件", records[1].title
    assert_equal "new", records[1].phase
    assert_equal "2020-04-01 16:30:00 UTC", records[1].created_at.to_s

    assert_equal "Aの件", records[2].title
    assert_equal "new", records[2].phase
    assert_equal "2020-04-01 10:30:00 UTC", records[2].created_at.to_s

    assert_equal "Eの件", records[3].title
    assert_equal "doing", records[3].phase
    assert_equal "2021-05-01 16:30:00 UTC", records[3].created_at.to_s

    assert_equal "Dの件", records[4].title
    assert_equal "doing", records[4].phase
    assert_equal "2021-03-01 10:30:00 UTC", records[4].created_at.to_s

    assert_equal "Fの件", records[5].title
    assert_equal "done", records[5].phase
    assert_equal "2022-03-01 10:30:00 UTC", records[5].created_at.to_s
  end

  # 期待値: - limitとoffsetで指定したデータ数の返却
  test "getメソッドのoffset指定が効いている事を担保する" do
    Pokotarou.execute("./test/test_data/questions/questions.yml")
    records = QuestionRepository.get(limit: 1, offset: 0, query: {})

    assert_equal 1, records.length

    records = QuestionRepository.get(limit: 4, offset: 0, query: {})

    assert_equal 4, records.length

    records = QuestionRepository.get(limit: 10, offset: 5, query: {})

    assert_equal 5, records.length
  end

  # 期待値: レコードのサイズが0件
  test "データが0件でも動作する事を担保する" do 
    records = QuestionRepository.get(limit: 10, offset: 5, query: {})

    assert_equal 0, records.length
  end

  # 期待値: 想定するレコードのヒット件数と一致すること
  test "タイトル名検索に関して担保する" do 
    Pokotarou.execute("./test/test_data/questions/questions.yml")

    query = { title_cont: "Aの件" }
    records = QuestionRepository.get(limit: 10, offset: 0, query: query)
    assert_equal 3, records.length

    query = { title_cont: "Bの件" }
    records = QuestionRepository.get(limit: 10, offset: 0, query: query)
    assert_equal 3, records.length
  end

  # 期待値: 想定するレコードのヒット件数と一致すること
  test "タイトルの名前検索に関して担保する" do 
    Pokotarou.execute("./test/test_data/questions/questions.yml")

    query = { title_cont: "Aの件" }
    records = QuestionRepository.get(limit: 10, offset: 0, query: query)
    assert_equal 3, records.length

    query = { title_cont: "Bの件" }
    records = QuestionRepository.get(limit: 10, offset: 0, query: query)
    assert_equal 3, records.length

    query = { title_cont: "Cの件" }
    records = QuestionRepository.get(limit: 10, offset: 0, query: query)
    assert_equal 2, records.length
  end

  # 期待値: 想定するレコードのヒット件数と一致すること
  test "内容検索に関して担保する" do 
    Pokotarou.execute("./test/test_data/questions/questions.yml")

    query = { content_cont: "CONTENT" }
    records = QuestionRepository.get(limit: 10, offset: 0, query: query)
    assert_equal 5, records.length

    query = { content_cont: "xxxxxx" }
    records = QuestionRepository.get(limit: 10, offset: 0, query: query)
    assert_equal 3, records.length
  end

  # 期待値: 想定するレコードのヒット件数と一致すること
  test "質問者名の検索に関して担保する" do 
    Pokotarou.execute("./test/test_data/questions/questions.yml")

    query = { member_name_cont: "Aさん" }
    records = QuestionRepository.get(limit: 10, offset: 0, query: query)
    assert_equal 2, records.length

    query = { member_name_cont: "Eさん" }
    records = QuestionRepository.get(limit: 10, offset: 0, query: query)
    assert_equal 2, records.length
  end

  # 期待値: 想定するレコードのヒット件数と一致すること
  test "段階の検索に関して担保する" do 
    Pokotarou.execute("./test/test_data/questions/questions.yml")

    query = { phase_eq: "new" }
    records = QuestionRepository.get(limit: 10, offset: 0, query: query)
    assert_equal 4, records.length

    query = { phase_eq: "doing" }
    records = QuestionRepository.get(limit: 10, offset: 0, query: query)
    assert_equal 3, records.length

    query = { phase_eq: "done" }
    records = QuestionRepository.get(limit: 10, offset: 0, query: query)
    assert_equal 3, records.length
  end

  # 期待値: 想定するレコードのヒット件数と一致すること
  test "登録日時の検索に関して担保する" do 
    Pokotarou.execute("./test/test_data/questions/questions.yml")

    query = { created_at_gteq: "2020-04-01 16:00" }
    records = QuestionRepository.get(limit: 10, offset: 0, query: query)
    assert_equal 6, records.length

    query = { created_at_gteq: "2020-03-01 16:00" }
    records = QuestionRepository.get(limit: 10, offset: 0, query: query)
    assert_equal 10, records.length

    query = { created_at_gteq: "2020-06-01 16:00" }
    records = QuestionRepository.get(limit: 10, offset: 0, query: query)
    assert_equal 0, records.length
  end
end