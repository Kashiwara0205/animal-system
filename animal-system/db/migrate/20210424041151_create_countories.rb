class CreateCountories < ActiveRecord::Migration[6.1]
  def change
    create_table :countories do |t|

      t.timestamps
    end
  end
end
