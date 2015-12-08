class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :player_1_name
      t.string :player_2_name

      t.timestamps null: false
    end
  end
end
