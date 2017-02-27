class CreateRounds < ActiveRecord::Migration[5.0]
  def change
    create_table :rounds do |t|
      t.integer :result
      t.belongs_to :room
      t.belongs_to :gov_team, references: :teams
      t.belongs_to :opp_team, references: :teams
      t.integer :round_number

      t.timestamps
    end
  end
end
