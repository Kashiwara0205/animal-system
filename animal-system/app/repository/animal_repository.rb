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
            .where(visible: true)
            .order(created_at: "DESC")
            .ransack(query)
            .result
    end

    def find id:
      Animal.find(id)
    end

    def update id:, info:
      record = Animal.find(id)
      record.update!(info)
    end

    def create info:
      Animal.create!(info)
    end

    def get_count query:
      Animal.ransack(query).result.size
    end
  end
end
