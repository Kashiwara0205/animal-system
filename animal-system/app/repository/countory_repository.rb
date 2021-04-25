class CountoryRepository
  class << self
    def get
      Countory.all.order(:name)
    end
  end
end