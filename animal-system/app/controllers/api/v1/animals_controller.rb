class Api::V1::AnimalsController < ApiController
  protect_from_forgery with: :null_session
  def index
    begin
      service = AnimalService.new(animal_repo: AnimalRepository)
      info, count = service.get(limit: params[:limit], offset: params[:offset], query: params[:query])

      render json: { info: info, count: count }, status: 200
    rescue => e
      res = { errors: e }
      render json: res, status: 500
    end
  end

  def update
    begin
      updated_record = {}
      ActiveRecord::Base.transaction do
        service = AnimalService.new(animal_repo: AnimalRepository)
        updated_record = service.update(id: params[:id], info: animal_params(params[:update_info]))
      end

      render json: { updated_record: updated_record }, status: 200
     rescue ActiveRecord::RecordInvalid => invalid
      render json: { errors: invalid.record.errors.full_messages }, status: 422
    rescue => e
      render json: { errors: e }, status: 500
    end
  end

  def create
    begin
      ActiveRecord::Base.transaction do
        service = AnimalService.new(animal_repo: AnimalRepository)
        service.create(info: animal_params(params[:create_info]))
      end
      render json: { }, status: 200
     rescue ActiveRecord::RecordInvalid => invalid
      render json: { errors: invalid.record.errors.full_messages }, status: 422
    rescue => e
      render json: { errors: e }, status: 500
    end
  end

  def animal_types
    begin
      service = AnimalTypeService.new(animal_type_repo: AnimalTypeRepository)
      render json: service.get_animal_types, status: 200
    rescue => e
      res = { errors: e }
      render json: res, status: 500
    end
  end

  private
  def animal_params info
    info.permit(:countory_id, :animal_type_id, :name, :weight, :height, :hair)
  end
end
