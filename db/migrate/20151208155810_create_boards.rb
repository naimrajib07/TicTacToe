class CreateBoards < ActiveRecord::Migration
  def change
    create_table :boards do |t|
      t.string :court
      t.integer :current_player, default: 1
      t.integer :status, default: 0
      t.references :game

      t.timestamps null: false
    end
  end
end
