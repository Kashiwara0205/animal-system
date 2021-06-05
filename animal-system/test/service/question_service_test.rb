require "test_helper"
require "minitest/autorun"

class QuestionServiceeTest < ActiveSupport::TestCase
  # 期待値: - attributesメソッドが叩かれていること
  #        - repositoryのgetメソッドが叩かれていること
  test "get_selectable_elementsメソッドの動作を担保する" do
    question_record = MiniTest::Mock.new
    question_record.expect :attributes, { id: 1, name: "questionA" }

    question_repo = MiniTest::Mock.new
    question_repo.expect :get, [question_record], [{limit: 0, offset: 50, query: { name_eq: "questionA" }}]
    question_repo.expect :get_count, 1, [{query: { name_eq: "questionA" }}]

    service = QuestionService.new(question_repo: question_repo)

    info, count = service.get(limit: 0, offset: 50, query: { name_eq: "questionA" })

    assert_equal 1, info[0][:id]
    assert_equal "questionA", info[0][:name]

    assert_equal 1, count

    question_record.verify
    question_repo.verify
  end
end