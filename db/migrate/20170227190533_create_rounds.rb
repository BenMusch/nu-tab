class CreateRounds < ActiveRecord::Migration[5.0]
  def change
    create_table :rounds do |t|
      t.integer :result
      t.belongs_to :room
      t.integer :round_number
      t.references :gov_team, foreign_key: true
      t.references :opp_team, foreign_key: true

      t.timestamps
    end
  end
end
