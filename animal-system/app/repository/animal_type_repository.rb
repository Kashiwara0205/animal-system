class AnimalTypeRepository
  class << self
    def get
      AnimalType.all.order(:name)
    end
  end
end