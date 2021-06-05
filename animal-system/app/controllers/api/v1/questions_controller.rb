class Api::V1::QuestionsController < ApiController
  protect_from_forgery with: :null_session
  def index
    begin
      service = QuestionService.new(question_repo: QuestionRepository)
      info, count = service.get(limit: params[:limit], offset: params[:offset], query: params[:query])

      render json: { info: info, count: count }, status: 200
    rescue => e
      res = { errors: e }
      render json: res, status: 500
    end
  end
end