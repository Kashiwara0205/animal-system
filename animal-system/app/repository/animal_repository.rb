class AnimalRepository
  class << self
    def get limit:, offset:, query:
        Animal.joins(:animal_type)
              .joins(:countory)
              .select("animals.name", 
                      "animals.weight", 
                      "animals.height",
                      "animals.body",
                      "animals.hair",
                      "animal_types.name",
                      "countories.name")
              .limit(limit)
              .offset(offset)
              .order(:id)
              .ransack(query)
              .result
    end

    def get_count query: query
      Animal.ransack(query).result.size
    end
  end
end