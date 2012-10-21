class CreateEpisodes < ActiveRecord::Migration
  def change
    create_table :episodes do |t|
      t.string :title
      t.references :director
      t.references :writer
      t.date :original_air_date

      t.timestamps
    end
    add_index :episodes, :director_id
    add_index :episodes, :writer_id
  end
end
