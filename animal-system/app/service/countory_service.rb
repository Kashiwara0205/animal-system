class CountoryService
  def initialize countory_repo:
    @countory_repo = countory_repo
  end

  def get_selectable_elements
    records = @countory_repo.get

    records.map { |m| 
      name = m.name
      { id: m.id, value: name, label: CountoryConst::NAME_TO_JA[name] } 
    }
  end
end
