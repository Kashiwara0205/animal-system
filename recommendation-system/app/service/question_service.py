class QuestionService:
  def __init__(self, question_m):
    self.question_m = question_m

  def recommendation(self, question_id):
    question = self.question_m.find(question_id)
    all_question = self.question_m.get_all()
    return all_question