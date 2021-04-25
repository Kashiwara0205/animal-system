class AnimalService
  def initialize animal_repo:
    @animal_repo = animal_repo
  end

  def get limit:, offset:, query:
    records = @animal_repo.get(limit: limit, offset: offset, query: query)

    records.map{|m| m.attributes }
  end
end