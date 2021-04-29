class AnimalTypeService
  def initialize animal_type_repo:
    @animal_type_repo = animal_type_repo
  end

  def get_selectable_elements
    records = @animal_type_repo.get

    records.map { |m| { key: m.id, value: AnimalTypeConst::NAME_TO_JA[m.name] } }
  end
end
