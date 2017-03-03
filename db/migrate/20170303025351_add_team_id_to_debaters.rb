class AddTeamIdToDebaters < ActiveRecord::Migration[5.0]
  def change
    add_reference :debaters, :team, foreign_key: true
  end
end
