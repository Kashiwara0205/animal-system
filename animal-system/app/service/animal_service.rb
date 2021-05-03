class AnimalService
  def initialize animal_repo:
    @animal_repo = animal_repo
  end

  def get limit:, offset:, query:
    records = @animal_repo.get(limit: limit, offset: offset, query: query)
    count = @animal_repo.get_count(query: query)

    info = records.map { |m| m.attributes }

    [info, count]
  end

  def update id:, info:
    @animal_repo.update(id: id, info: info)
    @animal_repo.find(id: id).attributes
  end
end
