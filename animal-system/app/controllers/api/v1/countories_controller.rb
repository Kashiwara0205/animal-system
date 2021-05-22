class Api::V1::CountoriesController < ApiController

  def index
    begin
      service = CountoryService.new(countory_repo: CountoryRepository)
      render json: service.get_selectable_elements, status: 200
    rescue => e
      res = { errors: e }
      render json: res, status: 500
    end
  end
end
