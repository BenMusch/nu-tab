class RemoveSchoolFromTeams < ActiveRecord::Migration[5.0]
  def change
    remove_column :teams, :school_id
  end
end
