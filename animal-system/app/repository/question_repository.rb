class QuestionRepository
  class << self
    def get limit:, offset:, query:
      merged_question_table()
        .limit(limit)
        .offset(offset)
        .group("questions.id")
        .order(phase: "ASC")
        .order(created_at: "DESC")
        .ransack(query)
        .result
    end

    def get_count query:
      merged_question_table().group("questions.id").ransack(query).result.length
    end

    private 

    def merged_question_table
      Question.joins(:member)
              .joins(question_tags: :tag)
              .select("questions.id",
                      "questions.title",
                      "questions.content",
                      "questions.phase",
                      "members.name as member_name",
                      "questions.created_at",
                      "questions.updated_at",
                      "GROUP_CONCAT(#{Tag.table_name}.name) as tag_name")
    end
  end
end