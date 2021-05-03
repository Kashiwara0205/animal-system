class Api::V1::AnimalsController < ActionController::Base
  def index
    begin
      service = AnimalService.new(animal_repo: AnimalRepository)
      info, count = service.get(limit: params[:limit], offset: params[:offset], query: params[:query])

      render json: { info: info, count: count }, status: 200
    rescue => e
      res = { error: e }
      render json: res, status: 500
    end
  end

  def update
    begin
      updated_record = {}
      ActiveRecord::Base.transaction do
        service = AnimalService.new(animal_repo: AnimalRepository)
        updated_record = service.update(id: params[:id], info: animal_params)
      end

      render json: { updated_record: updated_record }, status: 200
     rescue ActiveRecord::RecordInvalid => invalid
      render json: { error: invalid }, status: 422
    rescue => e
      render json: { error: e }, status: 500
    end
  end

  # 動作: animal_typesのデータが{ key: value }形式で返却されます
  def animal_types
    begin
      service = AnimalTypeService.new(animal_type_repo: AnimalTypeRepository)
      render json: service.get_selectable_elements, status: 200
    rescue => e
      res = { error: e }
      render json: res, status: 500
    end
  end

  private
  def animal_params
    params[:animal].permit(:countory_id, :animal_type_id, :name, :weight, :height, :hair)
  end
end
