class CountoryService
  def initialize countory_repo:
    @countory_repo = countory_repo
  end

  def get_selectable_elements
    records = @countory_repo.get

    records.map{|m| { key: m.id, value: CountoryConst::NAME_TO_JA[ m.name ] }}
  end
end