ENV['RAILS_ENV'] ||= 'test'
require_relative "../config/environment"
require "rails/test_help"

def delete_all_record model 
  model.all.each do |e|
    e.destroy!
  end
end

# 使用回数が多いマスターデータを事前データとして登録する
delete_all_record(AnimalType)
delete_all_record(Countory)
Pokotarou.execute("./test/test_data/preset.yml")

class ActiveSupport::TestCase
  # パラレルにしたら遅くなるのでコメント
  # parallelize(workers: :number_of_processors) 
end
