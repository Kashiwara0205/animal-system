class ActiveRecordConverter
  def self.to_ary_h active_records
    query_text = active_records.to_sql()

    from_idx = /FROM `/ =~ query_text

    select_column_names = 
      query_text[7..(from_idx - 2)].split(",")
                                   .map{|m| m.strip }

    key_column_names = 
      select_column_names.map do |m|
        if m.include?(" as ")
          as_idx = / as / =~ m
          m[(as_idx + 4)..]
        else
          m.split(".")[1].gsub("`", "")
        end
      end

      active_records.pluck(*select_column_names).map { |m| key_column_names.zip(m).to_h }
  end
end

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

  def get_csv query:
    active_records = @animal_repo.get_all(query: query)

    ActiveRecordConverter.to_ary_h(active_records)
  end

  def update id:, info:
    @animal_repo.update(id: id, info: info)
    @animal_repo.find(id: id).attributes
  end

  def create info:
    @animal_repo.create(info: info)
  end
end
