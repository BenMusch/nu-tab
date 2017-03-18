class AddHitPullUpToTeams < ActiveRecord::Migration[5.0]
  def change
    add_column :teams, :hit_pull_up, :boolean, default: false
  end
end
