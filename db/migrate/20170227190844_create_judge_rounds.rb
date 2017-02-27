class CreateJudgeRounds < ActiveRecord::Migration[5.0]
  def change
    create_table :judge_rounds do |t|
      t.boolean :chair
      t.belongs_to :round
      t.belongs_to :judge

      t.timestamps
    end
  end
end
