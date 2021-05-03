class AnimalRepository
  class << self
    def get limit:, offset:, query:
      Animal.joins(:animal_type)
            .joins(:countory)
            .select("animals.id",
                    "animals.name",
                    "animals.weight",
                    "animals.height",
                    "animals.body",
                    "animals.hair",
                    "animals.created_at",
                    "animals.updated_at",
                    "animal_types.id as animal_type_id",
                    "countories.id as countory_id")
            .limit(limit)
            .offset(offset)
            .order(:id)
            .ransack(query)
            .result
    end

    def get_count query:
      Animal.ransack(query).result.size
    end
  end
end
