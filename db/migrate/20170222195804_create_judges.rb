class CreateJudges < ActiveRecord::Migration[5.0]
  def change
    create_table :judges do |t|
      t.string :name
      t.integer :rank

      t.timestamps
    end
  end
end
