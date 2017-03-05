class AddSchoolToTeams < ActiveRecord::Migration[5.0]
  def change
    add_column :teams, :school_id, :integer
    add_foreign_key :teams, :schools
  end
end
