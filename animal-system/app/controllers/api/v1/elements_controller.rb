# セレクトボックス要素の構築などに使用
class Api::V1::ElementsController  < ActionController::Base

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

  # 動作: countoriesのデータが{ key: value }形式で返却されます
  def countories
    begin
      service = CountoryService.new(countory_repo: CountoryRepository)
      render json: service.get_selectable_elements, status: 200
    rescue => e
      res = { error: e }
      render json: res, status: 500
    end
  end
end