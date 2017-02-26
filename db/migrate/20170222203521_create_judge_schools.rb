class CreateJudgeSchools < ActiveRecord::Migration[5.0]
  def change
    create_table :judge_schools do |t|
      t.belongs_to :judge, foreign_key: true
      t.belongs_to :school, foreign_key: true

      t.timestamps
    end
  end
end
