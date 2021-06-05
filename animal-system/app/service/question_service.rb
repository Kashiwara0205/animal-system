class QuestionService
  def initialize question_repo:
    @question_repo = question_repo
  end

  def get limit:, offset:, query:
    records = @question_repo.get(limit: limit, offset: offset, query: query)
    count = @question_repo.get_count(query: query)

    info = records.map { |m| m.attributes }

    [info, count]
  end
end