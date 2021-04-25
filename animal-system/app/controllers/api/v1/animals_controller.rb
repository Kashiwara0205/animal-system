class Api::V1::AnimalsController  < ActionController::Base

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
end