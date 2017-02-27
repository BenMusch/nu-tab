class CreateDebaterTeams < ActiveRecord::Migration[5.0]
  def change
    create_table :debater_teams do |t|
      t.belongs_to :debater, foreign_key: true
      t.belongs_to :team, foreign_key: true

      t.timestamps
    end
  end
end
