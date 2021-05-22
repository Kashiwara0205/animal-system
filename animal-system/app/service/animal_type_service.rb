class AnimalTypeService
  def initialize animal_type_repo:
    @animal_type_repo = animal_type_repo
  end

  def get_animal_types
    records = @animal_type_repo.get

    records.map { |m|
      name = m.name 
      { id: m.id, value: name, label: AnimalTypeConst::NAME_TO_JA[name] } 
    }
  end
end
