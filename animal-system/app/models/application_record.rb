class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.to_ary_h

    arr = ["animals.id",
      "animals.name",
      "animals.weight",
      "animals.height",
      "animals.body",
      "animals.hair",
      "animals.created_at",
      "animals.updated_at",
      "animal_types.id as animal_type_id",
      "countories.id as countory_id"]
    
      rename_arr = [
        "id",
        "name",
        "weight",
        "height",
        "body",
        "hair",
        "created_at",
        "updated_at",
        "animal_type_id",
        "countory_id"
      ]

      pluck(*arr).map { |m| rename_arr.zip(m).to_h }
  end
end
