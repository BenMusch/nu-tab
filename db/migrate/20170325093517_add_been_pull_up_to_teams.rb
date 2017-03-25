class AddBeenPullUpToTeams < ActiveRecord::Migration[5.0]
  def change
    add_column :teams, :been_pull_up, :boolean, default: false
  end
end
