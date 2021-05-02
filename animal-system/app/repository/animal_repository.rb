class AnimalRepository
  class << self
    def get limit:, offset:, query:
      puts "00000000000000000"
      print query
      puts
      puts "--------------"
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
                    "animal_types.name as type_name",
                    "countories.name as countory_name")
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
