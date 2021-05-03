class AnimalTypeService
  def initialize animal_type_repo:
    @animal_type_repo = animal_type_repo
  end

  def get_selectable_elements
    records = @animal_type_repo.get

    records.map { |m|
      name = m.name 
      { key: m.id, value: name, label: AnimalTypeConst::NAME_TO_JA[name] } 
    }
  end
end
