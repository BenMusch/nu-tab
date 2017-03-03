class CreateDebaterRoundStats < ActiveRecord::Migration[5.0]
  def change
    create_table :debater_round_stats do |t|
      t.belongs_to :debater
      t.belongs_to :round
      t.float :speaks
      t.integer :ranks
      t.integer :position

      t.timestamps
    end
  end
end
