class QuestionRepository
  class << self
    def get limit:, offset:, query:
      merged_question_table()
            .limit(limit)
            .offset(offset)
            .order(created_at: "DESC")
            .ransack(query)
            .result
    end

    def test
      merged_question_table()
    end

    private

    def merged_question_table
      Question.joins(:member)
              .joins(question_tags: :tag)
              .select("questions.title",
                      "questions.content",
                      "members.name as member_name",
                      "GROUP_CONCAT(tags.name) as tag_name")
              .group("questions.id")
    end
  end
end