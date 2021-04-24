class CreateDogs < ActiveRecord::Migration[6.1]
  def change
    create_table :dogs do |t|
      t.references :countories, comment: "原産国"
      t.string :name
      t.integer :weight
      t.integer :height

      t.timestamps
    end

    execute <<-SQL
      ALTER TABLE `dogs` ADD amount_of_walk ENUM('always', 'almost', 'seldom') NOT NULL;
    SQL

    execute <<-SQL
      ALTER TABLE `dogs` ADD body ENUM('small', 'middle', 'large') NOT NULL;
    SQL

    execute <<-SQL
      ALTER TABLE `dogs` ADD hair ENUM('short', 'long') NOT NULL;
    SQL
  end
end
