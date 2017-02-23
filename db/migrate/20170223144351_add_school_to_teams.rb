class AddSchoolToTeams < ActiveRecord::Migration[5.0]
  def change
    add_reference :teams, :school, foreign_key: true
  end
end
